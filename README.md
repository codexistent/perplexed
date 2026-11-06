Perplexed is an AI-powered search engine based on the popular application Perplexity.

# Documentation

When building perplexed, we used the following tools and languages:

- The language **Dart**
- **Flutter** as our frontend framework
- **FastAPI**, a web framework based on Python for building APIs
- **Tavily**, a third-party api which enables fetching AI-based search results
- **Trafilatura** package to scrape web pages

During local development, we used a Python virtual environment to isolate our project dependencies. To install it for our project, we ran `python3 -m venv venv` under our `/server` directory and activated it via terminal with `./venv/Scripts/Activate.ps1`.

## Part 1: Homepage UI

Our front page can be split into two primary children: a navbar on the far left, and a 3-element column in the center which includes a header, search bar, and footer:
![homepage ui sketch](docs/media/homepage_ui.png)

To build this out, we created the following widgets under `lib/widgets`, for which `home_page.dart` then references.

- `SideBarButton`, `FooterLink` and `SearchBarButton` widgets are pretty self explanatory
- `SideBar` is a stateful widget containing five `SideBarButton` elements. Its state tracks if the bar is collapsed or not.
- `SearchSection` consisting of a search bar, three `SearchBarButton`s, and a blue search button

Then `home_page.dart` simply contains one `SideBar` widget and a column with a `SearchBarSection` and row of `FooterLink`s. The result looks something like the below.

![search page ui](docs/media/searchpageui.png)

### Part 2: Server

A huge chunk of Perplex's backend is our server, which contains our API that talks to the AI models to enable the core functionality of an 'AI powered' search engine. For this, we used the python-based framework FastAPI which is dependent on Uvicorn as the actual web server.

Our server, of which the most important function is `chat_endpoint` that takes in a user's query to output a result, has three services which the latter uses in sequence:

- `search_service.py` takes in the query and outputs info/sources from the web
  - There are two primary approaches you may take to get the results from the web. The first is using Gemini to split your query into multiple smaller queries (the potential issue with only doing one query is, for instance, if the user inputs their whole life story for their query, plugging that all into Google all at once is unlikely to return much useful search results), and searching each of those on the internet. The second is using a third-party service such as `Tavily` to get the search results. For the time being, we implemented the second approach as it is more direct.
  - After getting the sources from the web, we also want to get the content of the webpages instead of simply the URLs themselves. So we scrape the URLs as well, using `Trafilatura`. This portion of `search_service.py` could technically be broken into a separate step, but we kept it here because the function currently returns the each of the results in elements which contain the url, title, and content of pages bundled into one.
-
