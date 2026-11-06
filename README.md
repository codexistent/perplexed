Perplexed is an AI-powered search engine based on the popular application Perplexity.

# Documentation

When building perplexed, we used the following tools and languages:

- The language **Dart**
- **Flutter** as our frontend framework

## Part 1: Homepage UI

Our front page can be split into two primary children: a navbar on the far left, and a 3-element column in the center which includes a header, search bar, and footer:
![homepage ui sketch](docs/media/homepage_ui.png)

To build this out, we created the following widgets under `lib/widgets`, for which `home_page.dart` then references.

- `SideBarButton`, `FooterLink` and `SearchBarButton` widgets are pretty self explanatory
- `SideBar` is a stateful widget containing five `SideBarButton` elements. Its state tracks if the bar is collapsed or not.
- `SearchSection` consisting of a search bar, three `SearchBarButton`s, and a blue search button

Then `home_page.dart` simply contains one `SideBar` widget and a column with a `SearchBarSection` and row of `FooterLink`s. The result looks something like the below.

![search page ui](docs/media/searchpageui.png)
