
import argparse
import json
import re
import requests

def matches_filter(url, filters):
    # Check regex filters
    for pattern in filters['regex']:
        if re.search(pattern, url):
            return True
    # Check search engines (simple domain keywords)
    for engine in filters['search_engines']:
        if engine in url:
            return True
    # Check domain wildcards
    for domain_pattern in filters['domains']:
        # Convert *.domain.co to regex pattern
        domain_re = re.escape(domain_pattern).replace(r'\*', '.*')
        if re.search(domain_re, url):
            return True
    return False

def parse_bookmark_file(filename):
    links = []
    with open(filename, "r", encoding="utf-8") as f:
        lines = f.readlines()
    # Assumes file format is alternating lines: Title line, URL line in markdown link format [URL]
    # e.g.:
    # Title
    # [URL](URL)
    print(f"#lines: {len(lines)}")
    title = ""
    for i in range(0, len(lines)):
        # title = lines[i].strip()
        url_line = lines[i].strip()
        # print(f"line: {url_line}")
        # Extract URL from markdown style
        match = re.match(r'\[(https?://[^\]]+)\]\([^)]+\)', url_line)
        if not match:
    	    match = re.match(r'^(https?://[^ \t\r]*)', url_line)
        if match:
            url = match.group(1)
            links.append({'url': url, 'name': title})
        else:
            title = url_line
    return links

def main():
    parser = argparse.ArgumentParser(description='Bulk import bookmarks to Linkwarden')
    parser.add_argument('file', help='Bookmark file to import')
    parser.add_argument('--api-token', required=True, help='Linkwarden API token')
    parser.add_argument('--api-url', required=True, help='Base URL of Linkwarden API (e.g. https://linkwarden.example.com/api/v1)')
    parser.add_argument('-n', '--no-execute', action='store_true', help='Print what would be done, do not execute')
    args = parser.parse_args()

    # Filters - customize as needed
    filters = {
        'regex': [r'search=', r'q='],  # example to exclude search results URLs with query params
        'search_engines': ['google.', 'bing.', 'duckduckgo.'],  # contain simple domain indicators
        'domains': ['*.whatever.co']  # wildcard domains to exclude
    }

    links = parse_bookmark_file(args.file)

    # Apply filters
    filtered_links = [link for link in links if not matches_filter(link['url'], filters)]

    print(f"args: {args}")
    print(f"Total links found: {len(links)}")
    print(f"Links after filtering: {len(filtered_links)}")

    if args.no_execute:
        # Just log what would happen
        for link in filtered_links:
            print(f"Would upload: {link['name']} -> {link['url']}")
        print("No execution mode, exiting.")
        return

    headers = {
        'Authorization': f'Bearer {args.api_token}',
        'Content-Type': 'application/json'
    }

    # Chunk requests if needed; here we do all at once
    # body = [{'url': link['url'], 'name': link['name']} for link in filtered_links]
    # bulk_api_url = f"{args.api_url}/links/bulk-update"
    # response = requests.post(bulk_api_url, headers=headers, data=json.dumps(body))
    
    links_url = f"{args.api_url}/links"
    search_url = f"{args.api_url}/search"
    for link in filtered_links:
        # look if link is already there
        params = { 'searchQueryString': f"url:{link['url']}" }
        response = requests.get(search_url, headers=headers, params=params)
        # print(response.__dict__)
        response = requests.get(search_url, headers=headers, params=params)
        response_data = response.json()
        print(response_data)
        # Check if there are any results
        data = response_data.get('data', {})
        if isinstance(data, dict):
            links = data.get('links', [])
        else:
             # data is not a dict, e.g. it's a list or something else, so no links available
             links = []
        if links:
           print(f"Skipping {link['url']} as there are {len(links)} results to url search")
           # don't store link once more
           continue
        else:
           print("No results found.")
    
        # add link
        body = {'url': link['url'], 'name': link['name'], 'type': 'url'}
        # print(f"body: {body}")
        response = requests.post(links_url, headers=headers, data=json.dumps(body))
        # print(response.__dict__)
        # print(f"API Response: {response.status_code} {response.reason}")
        # print(response.text)
        if response.status_code >= 200 and response.status_code < 300:
            print(f"Uploaded {link}")
        elif response.status_code == 409:
            # print("Not needed")
            pass
        else:
            print(f"Can't upload: {link['url']}")

if __name__ == "__main__":
    main()

