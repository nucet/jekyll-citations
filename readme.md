# Citation generator for Eddie Dekel's site

## Basic usage

If you are reading this, you are probably an RA for the CET at Northwestern University and you want to know how to easily add papers to Eddie's website. Fortunately, it's not that difficult. You just have to edit the database file [papers.yml](_data/papers.yml).

You then copy and paste the text that appears on [this site](https://cet.econ.northwestern.edu/dekel/). At the time of writing, Google sites is in transition and there is no api for the new version. As a result, copying and pasting machine generated citations is the most automated solution available.

This is the only file you will typically have to edit. All of the other pages are generated from this database. I describe the templates that generate the site in the next section.

First, let's look at the formatting of the papers.yml database
```{yml}
-
    id_key: "d1989-overview"
    categories: 
      - "GT"
      - "DT"
    tags:
      - "surveys and perspectives"
      - "refinements"
      - "lexicographic beliefs"
    authors:
      - "Blume, Lawrence"
      - "Brandenburger, Adam"
      - "Dekel, Eddie"
    title: "An overview of lexicographic choice under uncertainty"
    journal: "Annals of Operations Research"
    vol: 19
    num: 1
    pages: "229-246"
    year: 1989
    pub: "Springer"
    pdf: "lexicographic-choice-uncertainty.pdf"
```
Some of these names should be self explanatory including `authors`, `title`, `journal`, `vol`, `num`, `pages`, `year`, and `pub`. These tags are just used in the citation. 

The `id_key` needs to be a unique for each entry, but it does not have to meaningful. It will be used as the citation name in the generated bib citations.

The `categories` key determines whether the paper is game theory (`"GT"`) or decision theory (`"DT"`). The paper can also be both (as in the above) or neither. If you add a category to a paper, it will appear on the page associated with that category (eg. [Game Theory](https://cet.econ.northwestern.edu/dekel/game-theory/)).

The `tags` key is very similar, but it is used for the finer categories like `"lexicographic beliefs"`. If you add a tag on a paper, it will appear on the page associated with that tag (eg. [Evolution](https://cet.econ.northwestern.edu/dekel/game-theory/evolution.html)).

The `pdf` tag gives the location of a pdf placed in the [pdf folder](pdf). If you add PDFs here, they will be hosted by GitHub, and links to the files will be automatically generated for you.

## How it works

You can see the template for  the bibliography [here](_layouts/bib.html) and the template for the lists [here](_layouts/list.html).

### Lists

Basically, for every tag (eg. reputation), the [list template](_layouts/list.html) loops over the entire database and only returns papers that have this tag. The syntax looks pretty weird because it's written in a template language called liquid. I used it because GitHub can read liquid templates to generate the [site](https://cet.econ.northwestern.edu/dekel).

I describe the steps below
1. Sort all papers in reverse chronological order
    ```
    {% assign sorted = site.papers | sort:"year" | reverse %}
    ```
2. Start a for loop over the sorted papers
    ```
    {% for paper in sorted %}
    ```
3. Continue if the page does not filter by category (Decision Theory/Game Theory) or if the category matches the filter.
    ```
    {% if page.category == nil or paper.categories contains page.category %}
    ```
4. same thing but with tags (reputation, mechanism design, etc)
    ```
    {% if page.tag == nil or paper.tags contains page.tag %}
    ```
5. Run the specific HTML to be repeated in the list using variables from the [database](_data\papers.yml). It also checks to see if the paper is single authored and reacts accordingly.
    ```
    <a href="{{ site.url }}{{ site.baseurl }}/pdf/{{ paper.pdf }}">{{ paper.title }}</a>{% if paper.authors.size > 1 %} (with {{ paper.authors | where_exp:"item", "item != 'Dekel, Eddie'" | join: " and "}}){% endif %}, <em>{{ paper.journal }}</em>, {{ paper.year }} <a href="{{ site.url }}{{ site.baseurl }}{{ paper.url }}">[bib]</a>
    <hr />
    ```
6. Close all the if statements and the fir loop
    ```
    {% endif %}
    {% endif %}
    {% endfor %}
    ```

### Bibs

The [bib template](_layouts/bib.html) is more self explanatory. For each paper, it just dumps all of the information from the database into bib format.

If you do not have access to this repository, you can email someone who committed recently. You should be able to find my email [on my GitHub profile](https://github.com/MattWThomas).