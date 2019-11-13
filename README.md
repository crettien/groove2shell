# groove2shell
A set of shell scripts to interact with Groove's api.
You need to install the jq package prior to using these scripts.
Each script matches a Groove API and accepts optional parameters.
*The paramaters are passed as a json string.*

Get the the API documentation [groove api](https://www.groovehq.com/docs/)

### Prerequistes

__On OS X__ run: `brew install jq`

__On Linux (Debian, Ubuntu)__ run: `apt-get install jq`

__Usage__

Get the most recent customers' list: `./listing_customers.sh '{"page":1}'`

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
      "id": "8222994910",
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
      "href": "http://api.groovehq.com/v1/customers/ericNeitter@aol.com",
      "links": {
        "tickets": {
          "href": "http://api.groovehq.com/v1/tickets?customer=ericNeitter%40aol.com"
        }
      },
      "id": "2104090070",
      "type": "Customer",
      "email": "ericneitter@aol.com",
      "name": "Eric Neitter",
      "first_name": "Eric",
      "last_name": "Neitter",
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
  ],
  "meta": {
    "pagination": {
      "current_page": 1,
      "total_pages": 59,
      "total_count": 118,
      "next_page": "http://api.groovehq.com/v1/customers?page=2"
    }
  }
}
```

Other scripts take over to parse json key:value pairs and navigate to next pages.

You can pipe the output to refine your query, in the following one-liner you'll be able to extract the list of emails:

```./listing_customers.sh '{"page":1,"per_page":2}' | jq '.customers[]|.email'```

Output sample:
```
"corentin.arboval@acmehq.com"
"ericneitter@aol.com"
```

### API scripts
The below scripts perform direct calls to underlying [groovehq api](https://www.groovehq.com/docs).<br>
The scripts all include a help function to display expected parameters and usage, invoke help using the -h or --help
parameter as in `./api_agents_listing.sh --help`


1. api\_agents\_listing.sh
2. api\_attachments\_listing.sh
3. api\_customer\_find.sh
4. api\_customers\_listing.sh
5. api\_folders\_listing.sh
6. api\_groups\_lisiting.sh
7. api\_mailboxes\_listing.sh
8. api\_messages\_listing.sh
9. api\_ticket\_update\_state.sh
10. api\_tickets\_count\_listing.sh
11. api\_tickets\_listing.sh

### Extended scripts
The below scripts perform extra tasks not directly provided by the api.<br>
The scripts all include a help function to display expected parameters and usage, invoke help using the -h or --help
parameter as in `./customer_tickets_close.sh --help`
1. customer\_tickets\_close.sh
2. customers\_find\_by\_name.sh
3. customers\_find\_by\_name\_count.sh
4. customers\_find\_by\_name\_count.sh

### Some examples
Extract a customer id given the customer's name `./customers_find_by_name.sh "John DOE" | ./customers_extract_id.sh`





