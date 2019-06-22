# Purlex Devlog

Overview
- Personal Link Shortener App
- Anonymous creation of digest
- Use persistent_ets as the datastore

Validations
- target page must exist

Routes
- get /                - intro page with forms
- get /:key            - redirect to :val or show error form
- get /stats/:key      - show stats for :key
- get /create?url=:url - show key
- get /urls            - list of URLs
- get /log             - hit log (live view log update)
- get /stats           - stat page (live view table filter/sort)

Return types: HTML or JSON

## 2019-06-11 TUE

- [x] Regen the app
- [x] Change name of Account object
- [x] Cleanup the HTML

## 2019-06-12 WED

- [x] Create an API for the storage object

## 2019-06-13 THU

- [x] Launch the storage objects in a genserver

## 2019-06-20 THU

- [x] Update Vim environment
- [x] Create test for GenStore module

## 2019-06-21 FRI

- [x] Create the link module
- [x] Create the log module
- [x] Design the web pages
- [x] Add bootstrap
- [x] Make a nav header (Home | URLs | Log | Stats)
- [x] Build out placeholder pages

## 2019-06-22 SAT

- [ ] Conditional render active links
- [ ] Work with HTML or JSON pages

## TBD

- [ ] Create stats/index with mocked-up data
- [ ] Create stats/show with mocked-up data

- [ ] Add LiveView

- [ ] Create a release
- [ ] Package the release in a docker container

