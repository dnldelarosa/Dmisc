# insert_html

    Code
      insert_html(file = test_path("insertHtml.html"))
    Warning <simpleWarning>
      no non-missing arguments to max; returning -Inf
      NAs introduced by coercion to integer range
    Output
      <body> <style scoped type="text/css">
        code{white-space: pre-wrap;}
        span.smallcaps{font-variant: small-caps;}
        span.underline{text-decoration: underline;}
        div.column{display: inline-block; vertical-align: top; width: 50%;}
        div.hanging-indent{margin-left: 1.5em; text-indent: -1.5em;}
        ul.task-list{list-style: none;}
          </style>
      
      
      
      <div class="container-fluid main-container">
      
      
      
      
      <div class="fluid-row" id="header">
      
      
      
      <h1 class="title toc-ignore">Untitled</h1>
      <h4 class="author">Daniel E. de la Rosa</h4>
      <h4 class="date">4/3/2021</h4>
      
      </div>
      
      
      <div id="r-markdown" class="section level2">
      <h2>R Markdown</h2>
      <p>This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <a href="http://rmarkdown.rstudio.com" class="uri">http://rmarkdown.rstudio.com</a>.</p>
      <p>When you click the <strong>Knit</strong> button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:</p>
      <pre class="r"><code>summary(cars)</code></pre>
      <pre><code>##      speed           dist       
      ##  Min.   : 4.0   Min.   :  2.00  
      ##  1st Qu.:12.0   1st Qu.: 26.00  
      ##  Median :15.0   Median : 36.00  
      ##  Mean   :15.4   Mean   : 42.98  
      ##  3rd Qu.:19.0   3rd Qu.: 56.00  
      ##  Max.   :25.0   Max.   :120.00</code></pre>
      </div>
      <div id="including-plots" class="section level2">
      <h2>Including Plots</h2>
      <p>You can also embed plots, for example:</p>
      <p><img src="data:image/png;base64,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" />
      <figure><figcaption>Fig. 1: insertHtml_files/figure-html/pressure-1</figcaption></figure></p>
      <p>Note that the <code>echo = FALSE</code> parameter was added to the code chunk to prevent printing of the R code that generated the plot.</p>
      </div>
      
      
      
      
      </div>
      
      <script>
      
      // add bootstrap table styles to pandoc tables
      function bootstrapStylePandocTables() {
        $('tr.odd').parent('tbody').parent('table').addClass('table table-condensed');
      }
      $(document).ready(function () {
        bootstrapStylePandocTables();
      });
      
      
      </script><!-- tabsets --><script>
      $(document).ready(function () {
        window.buildTabsets("TOC");
      });
      
      $(document).ready(function () {
        $('.tabset-dropdown > .nav-tabs > li').click(function () {
          $(this).parent().toggleClass('nav-tabs-open')
        });
      });
      </script><!-- code folding --><!-- dynamically load mathjax for compatibility with self-contained --><script>
        (function () {
          var script = document.createElement("script");
          script.type = "text/javascript";
          script.src  = "https://mathjax.rstudio.com/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML";
          document.getElementsByTagName("head")[0].appendChild(script);
        })();
      </script>
      </body>

---

    Code
      insertHTML(file = test_path("insertHtml.html"))
    Warning <simpleWarning>
      no non-missing arguments to max; returning -Inf
      NAs introduced by coercion to integer range
    Output
      <body> <style scoped type="text/css">
        code{white-space: pre-wrap;}
        span.smallcaps{font-variant: small-caps;}
        span.underline{text-decoration: underline;}
        div.column{display: inline-block; vertical-align: top; width: 50%;}
        div.hanging-indent{margin-left: 1.5em; text-indent: -1.5em;}
        ul.task-list{list-style: none;}
          </style>
      
      
      
      <div class="container-fluid main-container">
      
      
      
      
      <div class="fluid-row" id="header">
      
      
      
      <h1 class="title toc-ignore">Untitled</h1>
      <h4 class="author">Daniel E. de la Rosa</h4>
      <h4 class="date">4/3/2021</h4>
      
      </div>
      
      
      <div id="r-markdown" class="section level2">
      <h2>R Markdown</h2>
      <p>This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <a href="http://rmarkdown.rstudio.com" class="uri">http://rmarkdown.rstudio.com</a>.</p>
      <p>When you click the <strong>Knit</strong> button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:</p>
      <pre class="r"><code>summary(cars)</code></pre>
      <pre><code>##      speed           dist       
      ##  Min.   : 4.0   Min.   :  2.00  
      ##  1st Qu.:12.0   1st Qu.: 26.00  
      ##  Median :15.0   Median : 36.00  
      ##  Mean   :15.4   Mean   : 42.98  
      ##  3rd Qu.:19.0   3rd Qu.: 56.00  
      ##  Max.   :25.0   Max.   :120.00</code></pre>
      </div>
      <div id="including-plots" class="section level2">
      <h2>Including Plots</h2>
      <p>You can also embed plots, for example:</p>
      <p><img src="data:image/png;base64,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" />
      <figure><figcaption>Fig. 1: insertHtml_files/figure-html/pressure-1</figcaption></figure></p>
      <p>Note that the <code>echo = FALSE</code> parameter was added to the code chunk to prevent printing of the R code that generated the plot.</p>
      </div>
      
      
      
      
      </div>
      
      <script>
      
      // add bootstrap table styles to pandoc tables
      function bootstrapStylePandocTables() {
        $('tr.odd').parent('tbody').parent('table').addClass('table table-condensed');
      }
      $(document).ready(function () {
        bootstrapStylePandocTables();
      });
      
      
      </script><!-- tabsets --><script>
      $(document).ready(function () {
        window.buildTabsets("TOC");
      });
      
      $(document).ready(function () {
        $('.tabset-dropdown > .nav-tabs > li').click(function () {
          $(this).parent().toggleClass('nav-tabs-open')
        });
      });
      </script><!-- code folding --><!-- dynamically load mathjax for compatibility with self-contained --><script>
        (function () {
          var script = document.createElement("script");
          script.type = "text/javascript";
          script.src  = "https://mathjax.rstudio.com/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML";
          document.getElementsByTagName("head")[0].appendChild(script);
        })();
      </script>
      </body>

---

    Code
      insert_html(file = test_path("insertHtml_sc.html"))
    Warning <simpleWarning>
      no non-missing arguments to max; returning -Inf
      NAs introduced by coercion to integer range
    Output
      <body> <style scoped type="text/css">
        code{white-space: pre-wrap;}
        span.smallcaps{font-variant: small-caps;}
        span.underline{text-decoration: underline;}
        div.column{display: inline-block; vertical-align: top; width: 50%;}
        div.hanging-indent{margin-left: 1.5em; text-indent: -1.5em;}
        ul.task-list{list-style: none;}
          </style>
      
      
      
      <div class="container-fluid main-container">
      
      
      
      
      <div class="fluid-row" id="header">
      
      
      
      <h1 class="title toc-ignore">Untitled</h1>
      <h4 class="author">Daniel E. de la Rosa</h4>
      <h4 class="date">4/3/2021</h4>
      
      </div>
      
      
      <div id="r-markdown" class="section level2">
      <h2>R Markdown</h2>
      <p>This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <a href="http://rmarkdown.rstudio.com" class="uri">http://rmarkdown.rstudio.com</a>.</p>
      <p>When you click the <strong>Knit</strong> button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:</p>
      <pre class="r"><code>summary(cars)</code></pre>
      <pre><code>##      speed           dist       
      ##  Min.   : 4.0   Min.   :  2.00  
      ##  1st Qu.:12.0   1st Qu.: 26.00  
      ##  Median :15.0   Median : 36.00  
      ##  Mean   :15.4   Mean   : 42.98  
      ##  3rd Qu.:19.0   3rd Qu.: 56.00  
      ##  Max.   :25.0   Max.   :120.00</code></pre>
      </div>
      <div id="including-plots" class="section level2">
      <h2>Including Plots</h2>
      <p>You can also embed plots, for example:</p>
      <p><img src="data:image/png;base64,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" width="672"></p>
      <p>Note that the <code>echo = FALSE</code> parameter was added to the code chunk to prevent printing of the R code that generated the plot.</p>
      </div>
      
      
      
      
      </div>
      
      <script>
      
      // add bootstrap table styles to pandoc tables
      function bootstrapStylePandocTables() {
        $('tr.odd').parent('tbody').parent('table').addClass('table table-condensed');
      }
      $(document).ready(function () {
        bootstrapStylePandocTables();
      });
      
      
      </script><!-- tabsets --><script>
      $(document).ready(function () {
        window.buildTabsets("TOC");
      });
      
      $(document).ready(function () {
        $('.tabset-dropdown > .nav-tabs > li').click(function () {
          $(this).parent().toggleClass('nav-tabs-open')
        });
      });
      </script><!-- code folding --><!-- dynamically load mathjax for compatibility with self-contained --><script>
        (function () {
          var script = document.createElement("script");
          script.type = "text/javascript";
          script.src  = "https://mathjax.rstudio.com/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML";
          document.getElementsByTagName("head")[0].appendChild(script);
        })();
      </script>
      </body>

---

    Code
      insert_html(file = test_path("insertHtml_sc.html"), source_code = "r")
    Warning <simpleWarning>
      no non-missing arguments to max; returning -Inf
      NAs introduced by coercion to integer range
    Output
      <pre class="sourceCode r"><body> <style scoped type="text/css">
        code{white-space: pre-wrap;}
        span.smallcaps{font-variant: small-caps;}
        span.underline{text-decoration: underline;}
        div.column{display: inline-block; vertical-align: top; width: 50%;}
        div.hanging-indent{margin-left: 1.5em; text-indent: -1.5em;}
        ul.task-list{list-style: none;}
          </style>
      
      
      
      <div class="container-fluid main-container">
      
      
      
      
      <div class="fluid-row" id="header">
      
      
      
      <h1 class="title toc-ignore">Untitled</h1>
      <h4 class="author">Daniel E. de la Rosa</h4>
      <h4 class="date">4/3/2021</h4>
      
      </div>
      
      
      <div id="r-markdown" class="section level2">
      <h2>R Markdown</h2>
      <p>This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <a href="http://rmarkdown.rstudio.com" class="uri">http://rmarkdown.rstudio.com</a>.</p>
      <p>When you click the <strong>Knit</strong> button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:</p>
      <pre class="sourceCode r" class="r"><code>summary(cars)</code></pre>
      <pre class="sourceCode r"><code>##      speed           dist       
      ##  Min.   : 4.0   Min.   :  2.00  
      ##  1st Qu.:12.0   1st Qu.: 26.00  
      ##  Median :15.0   Median : 36.00  
      ##  Mean   :15.4   Mean   : 42.98  
      ##  3rd Qu.:19.0   3rd Qu.: 56.00  
      ##  Max.   :25.0   Max.   :120.00</code></pre>
      </div>
      <div id="including-plots" class="section level2">
      <h2>Including Plots</h2>
      <p>You can also embed plots, for example:</p>
      <p><img src="data:image/png;base64,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" width="672"></p>
      <p>Note that the <code>echo = FALSE</code> parameter was added to the code chunk to prevent printing of the R code that generated the plot.</p>
      </div>
      
      
      
      
      </div>
      
      <script>
      
      // add bootstrap table styles to pandoc tables
      function bootstrapStylePandocTables() {
        $('tr.odd').parent('tbody').parent('table').addClass('table table-condensed');
      }
      $(document).ready(function () {
        bootstrapStylePandocTables();
      });
      
      
      </script><!-- tabsets --><script>
      $(document).ready(function () {
        window.buildTabsets("TOC");
      });
      
      $(document).ready(function () {
        $('.tabset-dropdown > .nav-tabs > li').click(function () {
          $(this).parent().toggleClass('nav-tabs-open')
        });
      });
      </script><!-- code folding --><!-- dynamically load mathjax for compatibility with self-contained --><script>
        (function () {
          var script = document.createElement("script");
          script.type = "text/javascript";
          script.src  = "https://mathjax.rstudio.com/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML";
          document.getElementsByTagName("head")[0].appendChild(script);
        })();
      </script>
      </body> </pre>

---

    Code
      insert_html(file = test_path("insertHtml_sc.html"), keep_styles = F)
    Warning <simpleWarning>
      no non-missing arguments to max; returning -Inf
      NAs introduced by coercion to integer range
    Output
      <body>
      
      
      <div class="container-fluid main-container">
      
      
      
      
      <div class="fluid-row" id="header">
      
      
      
      <h1 class="title toc-ignore">Untitled</h1>
      <h4 class="author">Daniel E. de la Rosa</h4>
      <h4 class="date">4/3/2021</h4>
      
      </div>
      
      
      <div id="r-markdown" class="section level2">
      <h2>R Markdown</h2>
      <p>This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <a href="http://rmarkdown.rstudio.com" class="uri">http://rmarkdown.rstudio.com</a>.</p>
      <p>When you click the <strong>Knit</strong> button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:</p>
      <pre class="r"><code>summary(cars)</code></pre>
      <pre><code>##      speed           dist       
      ##  Min.   : 4.0   Min.   :  2.00  
      ##  1st Qu.:12.0   1st Qu.: 26.00  
      ##  Median :15.0   Median : 36.00  
      ##  Mean   :15.4   Mean   : 42.98  
      ##  3rd Qu.:19.0   3rd Qu.: 56.00  
      ##  Max.   :25.0   Max.   :120.00</code></pre>
      </div>
      <div id="including-plots" class="section level2">
      <h2>Including Plots</h2>
      <p>You can also embed plots, for example:</p>
      <p><img src="data:image/png;base64,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" width="672"></p>
      <p>Note that the <code>echo = FALSE</code> parameter was added to the code chunk to prevent printing of the R code that generated the plot.</p>
      </div>
      
      
      
      
      </div>
      
      <script>
      
      // add bootstrap table styles to pandoc tables
      function bootstrapStylePandocTables() {
        $('tr.odd').parent('tbody').parent('table').addClass('table table-condensed');
      }
      $(document).ready(function () {
        bootstrapStylePandocTables();
      });
      
      
      </script><!-- tabsets --><script>
      $(document).ready(function () {
        window.buildTabsets("TOC");
      });
      
      $(document).ready(function () {
        $('.tabset-dropdown > .nav-tabs > li').click(function () {
          $(this).parent().toggleClass('nav-tabs-open')
        });
      });
      </script><!-- code folding --><!-- dynamically load mathjax for compatibility with self-contained --><script>
        (function () {
          var script = document.createElement("script");
          script.type = "text/javascript";
          script.src  = "https://mathjax.rstudio.com/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML";
          document.getElementsByTagName("head")[0].appendChild(script);
        })();
      </script>
      </body>

---

    Code
      insert_html(file = test_path("insertHtml_sc.html"), source_code = "r", keep_styles = F)
    Warning <simpleWarning>
      no non-missing arguments to max; returning -Inf
      NAs introduced by coercion to integer range
    Output
      <pre class="sourceCode r"><body>
      
      
      <div class="container-fluid main-container">
      
      
      
      
      <div class="fluid-row" id="header">
      
      
      
      <h1 class="title toc-ignore">Untitled</h1>
      <h4 class="author">Daniel E. de la Rosa</h4>
      <h4 class="date">4/3/2021</h4>
      
      </div>
      
      
      <div id="r-markdown" class="section level2">
      <h2>R Markdown</h2>
      <p>This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <a href="http://rmarkdown.rstudio.com" class="uri">http://rmarkdown.rstudio.com</a>.</p>
      <p>When you click the <strong>Knit</strong> button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:</p>
      <pre class="sourceCode r" class="r"><code>summary(cars)</code></pre>
      <pre class="sourceCode r"><code>##      speed           dist       
      ##  Min.   : 4.0   Min.   :  2.00  
      ##  1st Qu.:12.0   1st Qu.: 26.00  
      ##  Median :15.0   Median : 36.00  
      ##  Mean   :15.4   Mean   : 42.98  
      ##  3rd Qu.:19.0   3rd Qu.: 56.00  
      ##  Max.   :25.0   Max.   :120.00</code></pre>
      </div>
      <div id="including-plots" class="section level2">
      <h2>Including Plots</h2>
      <p>You can also embed plots, for example:</p>
      <p><img src="data:image/png;base64,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" width="672"></p>
      <p>Note that the <code>echo = FALSE</code> parameter was added to the code chunk to prevent printing of the R code that generated the plot.</p>
      </div>
      
      
      
      
      </div>
      
      <script>
      
      // add bootstrap table styles to pandoc tables
      function bootstrapStylePandocTables() {
        $('tr.odd').parent('tbody').parent('table').addClass('table table-condensed');
      }
      $(document).ready(function () {
        bootstrapStylePandocTables();
      });
      
      
      </script><!-- tabsets --><script>
      $(document).ready(function () {
        window.buildTabsets("TOC");
      });
      
      $(document).ready(function () {
        $('.tabset-dropdown > .nav-tabs > li').click(function () {
          $(this).parent().toggleClass('nav-tabs-open')
        });
      });
      </script><!-- code folding --><!-- dynamically load mathjax for compatibility with self-contained --><script>
        (function () {
          var script = document.createElement("script");
          script.type = "text/javascript";
          script.src  = "https://mathjax.rstudio.com/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML";
          document.getElementsByTagName("head")[0].appendChild(script);
        })();
      </script>
      </body> </pre>
