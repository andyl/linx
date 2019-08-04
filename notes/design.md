# Purlex Design

Overview
- Personal Link Shortener App
- Anonymous creation of digest
- Use persistent_ets as the datastore

Validations
- target page must exist

Routes
- get /                - intro page with LiveView forms
- get /:key            - redirect to :val or show error form
- get /stats/:key      - show stats for :key
- get /create?url=:url - show key
- get /urls            - list of URLs
- get /log             - hit log (live view log update)
- get /stats           - stat page (live view table filter/sort)
- get /badpage/:key    - shows error when url is bad

Return types: HTML or JSON

