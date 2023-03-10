# Research Applications

![research](../figs/aiart/entelecheia_economic_research.png)

## Textual analysis

Textual analysis has gained significant popularity in recent years, especially in the field of asset pricing, macroeconomics, and other related fields. This approach involves analyzing large volumes of text to extract meaningful insights and information, which can be used to inform decision-making.

One of the primary reasons for the growing popularity of textual analysis is that it enables researchers to measure economic concepts that are otherwise hard or impossible to measure. For example, sentiments, emotions, and attitudes can be extracted from social media posts, news articles, and other textual data to provide insights into consumer behavior, market trends, and other economic indicators.

Interestingly, the simplest applications of textual analysis have proven to be the most successful so far. Many cutting-edge methods of machine learning, such as deep learning and neural networks, are not always necessary and can even be counter-productive, similar to kitchen-sink regressions that are prone to over-fitting.

Therefore, the advice for researchers interested in textual analysis is to keep it simple and stay close to the text. This means reading a lot of relevant texts and using basic techniques to extract insights. The frontier of this field is more in learning from new data rather than using fancy techniques.

- Textual analysis is increasingly popular in asset pricing, macroeconomics, and other fields.
- It enables researchers to measure economic concepts that are otherwise hard or impossible to measure.
- Simple applications of textual analysis have been the most successful so far.
- Many cutting-edge methods of machine learning are not necessary and can even be counter-productive.
- The advice is to keep it simple, stay close to the text, and read a lot.
- The frontier of the field is in learning from new data rather than using fancy techniques.

## Firm-Level Political Risk: Measurement and Effects

{cite:t}`hassan2019firm`

- The paper develops a measure of political risk for individual US firms based on the share of their earnings conference calls devoted to political risks.
- The measure is validated by correctly identifying calls with extensive conversations on political risks and correlating with the firm???s actions and stock market volatility.
- Firms exposed to political risk retrench hiring and investment and actively lobby and donate to politicians.
- The variation in the measure is mainly at the firm level, and the dispersion of firm-level political risk increases during high aggregate political risk times.
- Firms that spend more time discussing risks associated with a given political topic tend to increase lobbying on that topic in the following quarter.

**Conference Call Transcripts**

- The dataset includes 326,247 earnings conference call transcripts from 11,943 firms headquartered in 84 different countries, spanning from 2002 to 2020.
- Conference calls occur typically four times a year after earnings releases.
- The calls consist of a management presentation followed by a Q&A session with the firm's analysts.
- On average, the Q&A session involves 0-70 questions and lasts approximately 45 minutes.

**Measure of Political Risk**

- The measure of political risk is computed by counting the number of occurrences of political bigrams in conjunction with a synonym for risk or uncertainty and dividing it by the total number of bigrams in the transcript.

- The formula for the measure is given as:

- $PRisk_{it} = \frac{1}{B_{it}}\sum_{b}^{B_{it}}{1[ b \in \mathbb{P}\setminus\mathbb{N}] \times 1[|b-r| \lt 10] \times f_{b,\mathbb{P}}/B_{\mathbb{P}}}$

- where $r$ is the position of the nearest synonym of risk or uncertainty, $b = 0,1,\ldots B_{it}$ are the bigrams contained in the call of firm $i$ at time $t$, and $\mathbb{P}$ denotes the set of political bigrams.

- The formula applies the "$tf \times idf$" method to calculate the weight of the bigrams in measuring political risk.

```{figure} ../figs/intro_nlp/research/2.png
---
width: 80%
name: fig-synonyms
---
Synonyms for ???risk??? or ???uncertainty???
```

**Measuring news about the mean: $PSentiment_{it}$**

- The measure of news about the mean is calculated using the same approach to measure the mean of political news.

- The sentiment of political news is measured by counting positive and negative words used in conjunction with a political bigram.

- The formula for measuring news about the mean is given as:

- $PSentiment_{i,t} = \frac{1}{B_{it}} \sum_{b}^{B_{it}} \Big( 1[ b \in \mathbb{P}\setminus\mathbb{N}] \times \frac{f_{b,\mathbb{P}}}{B_{\mathbb{P}}} \times \sum_{c=b-10}^{b+10} S(c) \Big)$,

- where $\mathbb{P}$ denotes the set of political bigrams, $S$ assigns sentiment to each word in the vicinity of the bigram, and $B_{it}$ represents the total number of bigrams in the transcript.

- The correlation between the measure of political risk and the measure of news about the mean is negative, with $Corr(PRisk_{it}, PSentiment_{it}) = ???0.095^{***}$.

**$PRisk_{it}$**

- $PRisk_{it}$ is a measure that identifies conversations related to risks associated with political topics.
- The bigrams with the highest scores are intuitively linked to politics, such as "the constitution," "public opinion," "interest groups," and "the FAA."
- The transcripts with the highest $PRisk_{it}$ values are typically centered around discussions about ballot initiatives, legislation, regulation, government expenditure, and other politically relevant topics.

```{figure} ../figs/intro_nlp/research/4.png
---
width: 80%
name: fig-highest-prisk
---
Transcripts with the highest $PRisk_{it}$
```

**Example: Duke Energy Corporation**

```{figure} ../figs/intro_nlp/research/5.png
---
width: 500px
name: fig-duke-energy
---
A coal company???s $PRisk_{it}$
```

## Sources and Transmission of Country Risk

{cite:t}`hassan2021sources`

- The paper uses textual analysis of earnings conference calls held by listed firms globally to measure country risk.
- The firm-country-quarter-level data is used to identify spikes in perceived country risk, known as "crises," and their pattern of transmission to foreign firms.
- The pattern of transmission during crises usually follows a gravity structure, but it changes significantly during crises.
- Elevated perceptions of a country's riskiness by foreign and financial firms lead to significant falls in local asset prices, capital outflows, and reductions in firm-level investment and employment.
- Risk transmitted from foreign countries also affects the investment decisions of domestic firms.
- The cross-country pattern of interest rates and currency risk premia can be explained by the heterogeneous currency loadings on perceived global risk.

**Data and Methodology**

For each of 56 countries assemble a training library, $\mathbb{T}^{C}$

- The training library consists of all "Country Commerce" reports published by the Economist Intelligence Unit from 2002 to 2016 and all names of the country, names of towns with more than 15,000 inhabitants in 2018, and administrative subdivisions from geonames.org and CIA World Factbook.
- $tf \times idf$ is used to identify bigrams that are indicative of discussions of each country.
- A bigram is considered indicative of discussions of country $C$ if it is frequent in $C$'s training library and rarely used in other countries' libraries.

**Four Dimensions of $CountryRisk_{i,c,t}$**

1. Risk a given set of firms K associates with country c:

   $CountryRisk_{c,t}^{K} = \frac{1}{N_K}\sum CountryRisk_{i,c,t}$

2. Foreign risks perceived by firm i at time t:

   $ForeignRisk_{i,t} = \sum_{c \ne d(i)} CountryRisk_{i,c,t}$

3. Transmission of risk from o to d at time t:

   $TransmissionRisk_{o \to d,t} = \frac{1}{N_d}\sum CountryRisk_{i,o,t}$

4. Global Risk at time t:

   $GlobalRisk_{t} = \frac{1}{N_I}\frac{1}{N_C}\sum_{i \in I}\sum_{c \in C} CountryRisk_{i,c,t}$

**Measuring Exposure, Sentiment, and Firm Risk**

- $CountryExposure_{i,c,t}$ : tf ?? idf weighted share of words related to country c
- $CountrySentiment_{i,c,t}$ : tf ?? idf weighted sum of tone words toward country c (Loughran & McDonald 2011) (Proxy for positive/negative news about country c)
- $FirmRisk_{i,t}$ : Unweighted count of risk words. (Proxy for overall risk faced by the firm)

```{figure} ../figs/intro_nlp/research/7.png
---
width: 80%
name: fig-country-risk-greece
---
Financial and non-financial risk: Greece
```

```{figure} ../figs/intro_nlp/research/8.png
---
width: 80%
name: fig-country-risk-thailand
---
Financial and non-financial risk: Thailand
```

```{figure} ../figs/intro_nlp/research/9.png
---
width: 80%
name: fig-country-risk-global
---
Financial and non-financial risk: Global
```

## Text-Based Network Industries and Endogenous Product Differentiation

{cite:t}`hoberg2016text`

- The paper studies how firms differ from their competitors using time-varying measures of product similarity based on text-based analysis of firm 10-K product descriptions.
- The time-varying set of product similarity measures enables the generation of new industries in which firms can have their own distinct set of competitors.
- The new sets of competitors explain specific discussion of high competition, rivals identified by managers as peer firms, and changes to industry competitors following exogenous industry shocks.
- The study finds evidence that firm R&D and advertising are associated with subsequent differentiation from competitors, consistent with theories of endogenous product differentiation.
- Cosine similarity is the most popular way of calculating similarity.
- The formula for cosine similarity is $S\_{i,j} = c_i \cdot c_j$, where $c_i$ is the normalized representative vector of words for document $i$.
- This approach provides a creative way of figuring out who is competing with whom, using text-based analysis of firm 10-K product descriptions to measure product similarity and identify distinct sets of competitors.

**Product Descriptions to Vector**

- Product descriptions are converted to vectors by only keeping nouns (according to webster.com) and proper nouns, while dropping the most commonly used nouns.
- The resulting vector ($c_i$) consists of binary values for included words.
- The cosine similarity between all firm-year pairs results in a large matrix with firm-year as rows and columns.
- The firm-year pairs are clustered year by year to form yearly industry clusters.

**Results**

- The study uses text-based analysis of firm 10-K product descriptions to track changes in industries and identify competitors.
- This approach can be used to form industry definitions and track who is competing with whom.
- One drawback of using 10-K's is that they are only available for US firms, limiting the generalizability of the findings.

```{figure} ../figs/intro_nlp/research/10.png
---
width: 600px
name: fig-product-similarity
---
Industry clusters based on product similarity
```

## Measuring Economic Policy Uncertainty

{cite:t}`baker2016measuring`

```{figure} ../figs/intro_nlp/research/11.png
---
width: 80%
name: fig-epu
---
Economic Policy Uncertainty
```

- The paper develops a new index of economic policy uncertainty (EPU) based on newspaper coverage frequency.
- The index is found to proxy for movements in policy-related economic uncertainty, as evidenced by human readings of 12,000 newspaper articles.
- The US index spikes during major political events such as tight presidential elections, Gulf Wars I and II, the 9/11 attacks, and the failure of Lehman Brothers.
- The study finds that policy uncertainty raises stock price volatility and reduces investment and employment in policy-sensitive sectors like defense, healthcare, and infrastructure construction using firm-level data.
- At the macro level, policy uncertainty innovations foreshadow declines in investment, output, and employment in the United States and 12 major economies in a panel VAR setting.
- The EPU rose dramatically in the 1930s (from late 1931) and has drifted upwards since the 1960s, as seen by extending the US index back to 1900.

**This proxy for Economic Policy Uncertainty (EPU) comes from computer searches of newspapers**

- US index: 10 major papers get monthly counts of articles with:

  - `E` {economic or economy}, and
  - `P` {regulation or deficit or federal reserve or congress or legislation or white house}, and
  - `U` {uncertain or uncertainty}

- Divide the count for each month by the count of all articles

- Normalize and sum 10 papers to get the U.S monthly index

**Constructing the US News-Based EPU Index**

**Newspapers:**

- Boston Globe
- Chicago Tribune
- Dallas Morning News
- Los Angeles Times
- Miami Herald
- New York Times
- SF Chronicle
- USA Today
- Wall Street Journal
- Washington Post

**Validation: Running Detailed Human Audits**

10 undergraduates read ??? 10,000 newspaper articles to date using a 63-page audit guide to code articles if they discuss ???economic uncertainty??? and ???economic policy uncertainty???

```{figure} ../figs/intro_nlp/research/12.png
---
width: 80%
name: fig-epu-human-audit
---
Human audit of newspaper articles
```

**US News-based economic policy uncertainty index**

```{figure} ../figs/intro_nlp/research/13.png
---
width: 80%
name: fig-epu-us
---
US News-based economic policy uncertainty index
```

**Twitter text uncertainty measures**

```{figure} ../figs/intro_nlp/research/14.png
---
width: 80%
name: fig-epu-twitter
---
Twitter text uncertainty measures
```

**???world uncertainty index??? covering 143 countries from Economist Intelligence Unit text**

```{figure} ../figs/intro_nlp/research/15.png
---
width: 80%
name: fig-epu-world
---
World uncertainty index
```

**Global average of all 143 countries**

```{figure} ../figs/intro_nlp/research/16.png
---
width: 80%
name: fig-epu-global
---
Global average of all 143 countries
```

## The Diffusion of Disruptive Technologies

{cite:t}`bloom2021diffusion`

- The paper identifies 29 disruptive technologies and documents their diffusion across firms and labor markets in the U.S. using textual analysis of patents, job postings, and earnings calls.
- The locations where disruptive technologies are developed are geographically highly concentrated, even more so than overall patenting.
- As the technologies mature and the number of new jobs related to them grows, they gradually spread geographically. While initial hiring is concentrated in high-skilled jobs, over time the mean skill level in new positions associated with the technologies declines, broadening the types of jobs that adopt a given technology.
- The geographic diffusion of low-skilled positions is significantly faster than higher-skilled ones, so that the locations where initial discoveries were made retain their leading positions among high-paying positions for decades.
- Pioneer locations are more likely to arise in areas with universities and high skilled labor pools.

**Five Stylized Facts on Disruptive Technologies**

- The development and initial employment of disruptive technologies are highly concentrated geographically.
- The hiring associated with new technologies gradually spreads over time, leading to region broadening.
- The skill level required for tech jobs declines sharply over time, leading to skill broadening.
- Low-skill jobs associated with a given technology spread out significantly faster than high-skill jobs.
- Pioneer locations retain a long-lasting advantage in high-skilled jobs.

**Data Sources**

1. Full text of USPTO patents (1976-2016)

   - Typically follow a research paper format ??? invention title, abstract, claim, description.

2. Transcripts of Earnings Conference Calls (2002-19)

   - Discussions of 300k+ quarterly earnings by 12k publicly listed firms.
   - Typically contains management presentation followed by analyst Q & A.

3. Full text of 200M+ online job postings from BG (2007, 2010-19).

   - Scraped from job forums (e.g., Glassdoor.com) and employer websites.
   - Geo-coded and assigned to SOC Codes

**Step 1: Identify Technical Bigrams from Patents**

Use the list of 35,063 technical bigrams associated with influential inventions to identify and document the diffusion of 29 disruptive technologies across firms and labor markets in the U.S.

1. Extract all (17M+) bigrams US patents (1976-2016)
2. Remove common bigrams used before 1970 (Corpus of Historical American English)
3. Keep bigrams that account for at least 1000 citations.

**Top Bigrams in Patents**

```{figure} ../figs/intro_nlp/research/17.png
---
width: 80%
name: fig-patents-top-bigrams
---
Top Bigrams in Patents
```

**Step 2: Identify Disruptive Technologies from Earnings Calls**

Identify technical bigrams that are discussed in earnings calls with increasing frequency, while keeping those that are below 10% of the maximum frequency in the first year. This results in a total of 305 technical bigrams.

```{figure} ../figs/intro_nlp/research/18.png
---
width: 80%
name: fig-ec-top-bigrams
---
Technical bigrams in earnings calls
```

**Technical vs non-technical bigrams**

Non-technical bigrams refer to bigrams that appear in earnings calls but not in patents.

```{figure} ../figs/intro_nlp/research/19.png
---
width: 80%
name: fig-technical-non-technical
---
Technical vs non-technical bigrams
```

**Step 3: Bigrams to Technologies**

There are two alternative approaches:

- The "Supervised" approach groups bigrams with similar meaning to measure the spread of 29 specific technologies. This approach involves adding synonyms and manually auditing each bigram. Examples include grouping "smartphone tablet" and "android phones" under "Smart Devices" and grouping "3d printer" and "additive manufacturing" under "3D printing."

- The "Unsupervised" approach treats each technical bigram as a separate technology without any further intervention. This approach is used as a robustness check.

**Technology Exposure**

The technology exposure is measured at the patent, earnings call, and job level using the following formula:

$\text{exposure}{i,\tau,t} = 1{b{t} \in D_{i,t}}$

Here, $D_{i,t}$ refers to the set of bigrams present in a job posting or earnings call made at time $t$, and $b_{\tau}$ is a bigram linked to technology $\tau$.

**Example Jobs Exposed to Smart Devices**

```{figure} ../figs/intro_nlp/research/21.png
---
width: 80%
name: fig-example-jobs
---
Example Jobs Exposed to Smart Devices
```

- The average number of job postings containing a technical bigram is 59,013, while the average number of mentions of top non-technical bigrams in earnings calls is 157.

**Define an Emergence Year for each Technology**

To define an emergence year for each technology, the following steps are taken:

1. The share of earnings calls mentioning a technology is measured.
2. The year when the time series first reaches at least 10% of its maximum is defined as the "technology year of emergence".

```{figure} ../figs/intro_nlp/research/22.png
---
width: 80%
name: fig-emergence-year
---
Technology Emergence Years
```

**Share Exposed Firms and Job Postings ??? Corr. 80%**

```{figure} ../figs/intro_nlp/research/23.png
---
width: 80%
name: fig-share-exposed-firms
---
Share Exposed Firms and Job Postings ??? Corr. 80%
```

**Pioneer Locations**

The pioneer locations are identified as the geographical locations that account for 50% of the technology patents 10 years prior to the year of emergence.

```{figure} ../figs/intro_nlp/research/24.png
---
width: 80%
name: fig-pioneer-locations
---
Pioneer Locations
```

**Broadening over Time and Pioneer Locations**

```{figure} ../figs/intro_nlp/research/25.png
---
width: 80%
name: fig-broadening-over-time
---
Broadening over Time and Pioneer Locations
```

## When Words Sweat

{cite:t}`netzer2019words`

- esearchers analyzed text from thousands of loan requests from an online crowdfunding platform.
- Borrowers' intentions, circumstances, and personality traits were detected in the text and were found to be predictive of default up to three years later.
- The text analysis was able to detect signals that the borrowers may not have been aware of or intentionally conveyed.
- The study shows the potential of using natural language processing techniques to improve credit risk assessments.

Suppose you are considering lending $2,000 to one of two borrowers on a crowdfunding website, both with similar financial and demographic characteristics. However, their loan applications differ in their text:

Borrower #1:

"I am hardworking, married for 25 years, and have two wonderful boys. I need a $2,000 loan to fix our roof. Thank you, God bless you, and I promise to pay you back."

Borrower #2:

"I need a $2,000 loan to cover the cost of repairing my roof. I pay all bills on time."

Which borrower is more likely to default?

Loan requests written by defaulting borrowers tend to include words related to family, financial and general hardship, mentions of God, and the near future. They may also plead for help and use present or future tense verbs. This suggests that borrower #1 may be more likely to default.

**Loan Application Words Predicting Repayment**

```{figure} ../figs/intro_nlp/research/26.png
---
width: 80%
name: fig-predicting-repayment
---
Words Predicting Repayment
```

```{figure} ../figs/intro_nlp/research/27.png
---
width: 80%
name: fig-predicting-default
---
Words Predicting Default
```

## The Legislative Influence Detector

{cite:t}`burgess2016legislative`

- State legislatures introduce over 45,000 bills each year.
- Legislators frequently copy text from other states or interest groups when drafting bills.
- Existing approaches to detecting text reuse are slow, biased, and incomplete.
- The Legislative Influence Detector (LID) uses the Smith-Waterman local alignment algorithm to detect sequences of text that occur in model legislation and state bills.
- LID has found over 45,000 instances of bill-to-bill text reuse and over 14,000 instances of model-legislation-to-bill text reuse.
- LID reduces the time it takes to manually find text reuse from days to seconds.

**Interest Group Influence**

- The study focuses on two major interest group associations: ALEC (conservative) and ALICE (liberal).
- These associations represent a large number of interest groups, with ALEC representing the National Rifle Association (NRA) and ALICE representing major labor associations.
- Both ALEC and ALICE have thousands of model bills covering various topics such as labor rights, voting regulations, environmental issues, and economic issues.
- The main goal of these associations is to provide a database of model legislation for politicians and activists to implement in state legislatures.

```{figure} ../figs/intro_nlp/research/28.png
---
width: 80%
name: fig-alec-alice
---
ALEC and ALICE
```

```{figure} ../figs/intro_nlp/research/29.png
---
width: 80%
name: fig-alec-alice
---
Match between Scott Walker's bill and a bill from Louisiana
```

## From Pork to Policy

{cite:t}`catalinac2018pork`

- The study examines how candidates adopt different electoral strategies under different electoral systems and intraparty competition.
- The researchers analyzed 7,497 Japanese-language candidate election manifestos from before and after Japan's 1994 electoral reform using probabilistic topic modeling and qualitative interpretations.
- The findings suggest that the reform, which eliminated intraparty competition, led to a decline in particularism and an increase in promises of programmatic goods such as national security among candidates affiliated with Japan's Liberal Democratic Party.
- This change is not explained by the entry of new candidates or other variables that could increase discussion of national security.
- Opposition candidates relied on programmatic goods under both electoral systems, consistent with the theory.

```{figure} ../figs/intro_nlp/research/31.png
---
width: 50%
name: fig-pork-to-policy
---
From Pork to Policy
```

## Transparency and Deliberation Within the FOMCF

{cite:t}`hansen2018transparency`

- The study examines how transparency affects monetary policymakers' deliberations in the Federal Open Market Committee (FOMC).
- Computational linguistics algorithms are used to analyze communication patterns.
- A natural experiment in the FOMC in 1993 is used to explore the positive discipline effect and negative conformity effect.
- Large changes in communication patterns are found after transparency.
- A difference-in-differences approach is used to identify evidence for both effects.
- An influence measure is constructed, suggesting that the discipline effect dominates.

```{figure} ../figs/intro_nlp/research/32.png
---
width: 80%
name: fig-topic-distributions
---
Topic distributions
```

**Pro-Cyclical Topics**

```{figure} ../figs/intro_nlp/research/33.png
---
width: 80%
name: fig-pro-cyclical-topics
---
Pro-Cyclical Topics
```

**Counter-Cyclical Topics**

```{figure} ../figs/intro_nlp/research/34.png
---
width: 80%
name: fig-counter-cyclical-topics
---
Counter-Cyclical Topics
```

**Effect of Transparency**

- In 1993, the public availability of transcripts caused an unexpected transparency shock.
- The impact of increasing transparency includes:
  - Higher use of discipline and technocratic language, which is likely beneficial.
  - Higher conformity, which is likely costly.
- These findings highlight the tradeoffs that come with transparency in bureaucratic organizations.

```{figure} ../figs/intro_nlp/research/35.png
---
width: 80%
name: fig-transparency
---
Effect of Transparency
```

## Adjusting for Confounding with Text Matching

{cite:t}`roberts2020adjusting`

- This paper proposes a method to adjust for confounding in observational studies using text matching.
- Matching on text is particularly useful in situations where confounding factors cannot be observed or measured directly.
- The proposed method involves estimating a low-dimensional summary of the text and using it to match treated and control units.
- The method, called topical inverse regression matching, matches on both the topical content of confounding documents and the probability that each document is treated.
- The effectiveness of the method is demonstrated through two applications: the effect of author gender on citation counts in international relations literature and the effects of censorship on Chinese social media users.

**Application to online censorship in China**

- Gathered a dataset of Chinese social media posts, including both censored and uncensored posts, from 593 bloggers over a period of six months, totaling 150,000 posts.
- Utilized a modified version of propensity score matching to identify nearly identical posts, some of which were censored and some of which were not.
- Measured the censorability of subsequent posts using their text and analyzed whether censorship had a deterrence or backlash effect.

```{figure} ../figs/intro_nlp/research/36.png
---
width: 80%
name: fig-censorship-backlash
---
Censorship has a backlash effect
```

- Bloggers who are censored respond with more censorable content.

## Deciphering Monetary Policy Board Minutes with Text Mining

{cite:t}`lee2019deciphering`

- The study uses text mining to analyze Monetary Policy Board (MPB) minutes of Bank of Korea (BOK).
- A field-specific Korean dictionary and contiguous sequences of words (n-grams) are used to capture central bank communication subtleties.
- Text-based indicators help explain current and future BOK monetary policy decisions in conjunction with an augmented Taylor rule, indicating additional information beyond macroeconomic variables.
- The text-based indicators outperform English-based textual classifications, media-based measure of economic policy uncertainty, and databased measure of macroeconomic uncertainty.
- The study highlights the importance of using a field-specific dictionary and the original Korean text in the analysis.

```{figure} ../figs/intro_nlp/research/mp_procedure.png
---
width: 80%
name: fig-mp-procedure
---
Procedure of the study
```

```{figure} ../figs/intro_nlp/research/mp_tones.png
---
width: 80%
name: fig-mp-tones
---
Text-Based Indicators of MP Sentiments
```
