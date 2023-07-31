# Citation generator

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
    <p>
        <a href="{{ site.url }}{{ site.baseurl }}/pdf/{{ paper.pdf }}" target="_blank">{{ paper.title }}</a>
        {%- if paper.authors.size > 1 -%}
            {{ ' ' }}(with {{ paper.authors | where_exp:"item", "item != site.citations.author" | join: " and "}})
        {%- endif %},
        {% if paper.journal -%}
            <em>{{ paper.journal }}</em>,
        {%- endif %}
        {{ paper.year }}
        <a href="{{ paper.url | absolute_url }}" target="_blank">[bib]</a>
    </p>
    ```
6. Close all the if statements and the fir loop
    ```
    {% endif %}
    {% endif %}
    {% endfor %}
    ```

### Bibs

The [bib template](_layouts/bib.html) is more self explanatory. For each paper, it just dumps all of the information from the database into bib format.

If you do not have access to this repository, you can email someone who committed recently. You should be able to find my email [on my GitHub profile](https://github.com/mwt).