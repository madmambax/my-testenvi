ErrorStrings = {
    "1": "ValueError: *: Expected response code *, got * instad. *",
    "2": "ValueError: String '*' was not found on *",
    "3": "ValueError: Response took too long. Loading time: *ms Time limit: *ms.",
    "4": "ValueError: Artist search took too long. Search time: *ms  Time limit: *ms",
    "5": "ValueError: Artist * not found",
    "6": "ValueError: Top songs search took too long. Search time: *ms  Time limit: *ms",
    "7": "ValueError: Expected failure, test succeeded",
    "8": "ValueError: *: E-mail with message * was not found in *.",

}

# Report tmp file
TMP_LOG = "tmt_log.log"

# Website test data
URL = "https://robotframework.org/"
TEXT = "This test has a workflow that is created using keywords"
TIME = 1000

EXPECTED_RESPONSE_CODE = 208
EXPECTED_MESSAGE = "true"

# Spotify test data
ARTISTS = ["Adele", "Josh Newman", "Ed Sheeran", "Drake", "Ariana Grande", "Rihanna"]
ARTIST = "Adele"
COUNTRY = "CZ"
TIME = 1000
TIME2= 5000

CLIENT_ID = "1bdb6b77d0a346568b27b76c658d96b9"          # REPLACE
CLIENT_SECRET = "b69c4574973e44ada28ef8bcdb292315"      # REPLACE

OAUTH_TOKEN_URL = "https://accounts.spotify.com/api/token"
PAYLOAD = {"grant_type": "client_credentials"}
SEARCH_URL = "https://api.spotify.com/v1/search"
SEARCH_PROXIES = None
SEARCH_TIMEOUT = 30
ARTIST_SEARCH_URL = "https://api.spotify.com/v1/artists/"


TMT_ACCOUNT = ["https://TMT018.testrail.io/",  "radek.tester@seznam.cz",  "TestovaniSW"]


SUBJECTS = {"password_change": '=?UTF-8?B?Wm3Em25hIGhlc2xhIHByb2LEm2hsYSDDunNwxJvFoW7Emw==?='}