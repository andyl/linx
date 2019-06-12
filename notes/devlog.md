# Purlex Devlog

Overview
- Personal Link Shortener App
- Anonymous creation of digest
- Use persistent_ets as the datastore

Validations
- target page must exist

Routes
- get /                - show intro page with forms
- get /:key            - redirect to :val or show error form
- get /stats/:key      - show stats for :key
- get /create?url=:url - show key
- get /log             - hit log (live view log update)
- get /stats           - stat page (live view table filter/sort)

Return types: HTML or JSON

## TBD

- [ ] Regen the app
- [ ] Create an API for the link object
- [ ] Cleanup the HTML

- [ ] Change name of Account object
- [ ] Add LiveView

