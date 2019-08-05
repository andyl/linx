# Purlex Design

## Overview

- Personal Link Shortener App
- Anonymous creation of digest
- Use persistent_ets as the datastore

## Validations

- target page must exist

## Routes

| Status | Path                  | Desc                                    |
|--------|-----------------------|-----------------------------------------|
| done   | get /                 | intro page with LiveView forms          |
| done   | get /:key             | redirect to :val or show error form     |
| open   | get /stats/:key       | show stats for :key                     |
| open   | get /urls             | list of URLs                            |
| open   | get /log              | hit log (live view log update)          |
| open   | get /stats            | stat page (live view table filter/sort) |
| open   | post /create?url=:url | create key                              |

Return types: HTML or JSON

