# AutoGen AutoScraper Agent

**Web Scraping Central Bankers' Speeches**

The task involves creating a Python script to scrape the titles and URLs of speeches from the "Central Bankers' Speeches" web pages on the Bank for International Settlements website. The script will traverse pages 1 to 10, collecting the title and URL of each speech listed, and display the gathered information on the screen.

## 1. Objective

- Navigate to the specified section of the Bank for International Settlements website.
- Iterate through the designated pages.
- Scrape the title and URL of each speech listed.
- Display the collected information on the screen.

## 2. Specifications

- **Website URL**: [Central bankers' speeches](https://www.bis.org/cbspeeches/index.htm?m=256&cbspeeches_page=1)
- **Pages to Scrape**: 1 to 10
- **Data to Collect**: Title and URL of each speech
- **HTML Elements**:
  - Parent Div Class: `cbspeeches_list`
  - Title Div Class: `title`
- **Output Limit**: No more than 100 entries

## 3. Technical Approach

- Utilize a web scraping library such as BeautifulSoup to parse HTML content.
- Implement a loop to traverse through the pages.
- Within each page, target the specified div classes to extract the required information.
- Store the scraped data in a structured format.
- Print the result to the screen.

## 4. Instructions for AutoGen Agent

- **Task 1**: Navigate to the URL of the "Central Bankers' Speeches" page.
- **Task 2**: Initiate a loop to iterate through pages 1 to 10.
- **Task 3**: On each page, locate the table with class `documentList`. Within this table, find all occurrences of the div with class `title`.
- **Task 4**: For each occurrence of the `title` div, extract the text as the title of the speech, and the href attribute as the URL of the speech.
- **Task 5**: Store the title and URL in a structured format, like a list of dictionaries.
- **Task 6**: Ensure that no more than 100 entries are collected.
- **Task 7**: Print the collected data to the screen, displaying the title and URL of each speech.

This structured breakdown will serve as a clear guide for the AutoGen agent to understand and execute the web scraping task proficiently, adhering to the specified criteria and output requirements.

## Exaample Python Code for AutoGen Agent

You can check the example code at `examples/autogen/autoscraper.py` from the [course repo](https://github.com/chu-aie/deepnlp-2023) for the AutoGen agent to scrape the Central Bankers' Speeches web pages.
