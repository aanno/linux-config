
import argparse
import json
import re
import requests


def main():
    parser = argparse.ArgumentParser(description='Bulk import bookmarks to Linkwarden')
    parser.add_argument('--api-token', required=True, help='Linkwarden API token')
    parser.add_argument('--api-url', required=True, help='Base URL of Linkwarden API (e.g. https://linkwarden.example.com/api/v1)')
    parser.add_argument('-n', '--no-execute', action='store_true', help='Print what would be done, do not execute')
    args = parser.parse_args()

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
    
    # Query parameters
    params = {
        "sort": 1,      # Replace 1 with preferred sort type if needed
        "limit": 20,    # Limit the number of tags returned
        "cursor": "30"    # Leave blank for first page, set to cursor from previous response for pagination
    }

    links_url = f"{args.api_url}/links"
    search_url = f"{args.api_url}/search"
    tag_url = f"{args.api_url}/tags"

    # Make the GET request
    response = requests.get(tag_url, headers=headers, params=params)

    # Check response and print results
    if response.status_code == 200:
        json_response = response.json()
        # print(json.dumps(json_response, indent = 4))
        tags = [item["name"] for item in json_response["response"]]
        tags.sort()
        print("\n".join(tags))
    else:
        print(f"Error: {response.status_code} - {response.text}")

if __name__ == "__main__":
    main()

