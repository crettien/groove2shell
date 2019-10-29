# groove2shell
A set of shell scripts to interact with Groove's api
You need to install the jq package prior to using these scripts.

__On OS X__ run:
```brew install jq```

__On Linux (Debian, Ubuntu)__ run:
```apt-get install jq```

__Usage__

Get the most recent customers' list:
```./listing_customers.sh '{"page":1}'```

Expected output:
```json
{
  "customers": [
    {
      "href": "http://api.groovehq.com/v1/customers/corentin.arboval@acmehq.com",
      "links": {
        "tickets": {
          "href": "http://api.groovehq.com/v1/tickets?customer=corentin.arboval%40acmehq.com"
        }
      },
      "id": "8222992310",
      "type": "Customer",
      "email": "corentin.arboval@acmehq.com",
      "name": "corentin arboval",
      "first_name": "corentin",
      "last_name": "arboval",
      "about": null,
      "twitter_username": null,
      "title": null,
      "company_name": null,
      "phone_number": null,
      "location": null,
      "website_url": null,
      "linkedin_username": null,
      "custom": {},
      "avatar_url": "https://groovehq.com/avatars/original/missing.png"
    },
  {
    "href": "http://api.groovehq.com/v1/customers/jeanneitter@aol.com",
    "links": {
      "tickets": {
        "href": "http://api.groovehq.com/v1/tickets?customer=jeanneitter%40aol.com"
      }
    },
    "id": "2104090070",
    "type": "Customer",
    "email": "jeanneitter@aol.com",
    "name": "jean neitter",
    "first_name": "jean",
    "last_name": "neitter",
    "about": null,
    "twitter_username": null,
    "title": null,
    "company_name": null,
    "phone_number": null,
    "location": null,
    "website_url": null,
    "linkedin_username": null,
    "custom": {},
    "avatar_url": "https://groovehq.com/avatars/original/missing.png"
  }
  ]
  "meta": {
    "pagination": {
      "current_page": 1,
      "total_pages": 3,
      "total_count": 118,
      "next_page": "http://api.groovehq.com/v1/customers?page=2"
    }
  }

```

Other scripts take over to parse json key:value pairs and navigate to next pages.

You can pipe the output to refine your query, in the following one-liner you'll be able to extract the list of emails:

`./listing_customers.sh '{"page":1}' | jq '.customers[]|.email'