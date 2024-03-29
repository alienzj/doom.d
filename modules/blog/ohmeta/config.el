;;; blog/ohmeta/config.el -*- lexical-binding: t; -*-

(setq org-static-blog-publish-title "Metagenomics Research Blog"
      org-static-blog-publish-url "https://ohmeta.github.io/"
      org-static-blog-publish-directory ohmeta-blog-dir
      org-static-blog-posts-directory (concat ohmeta-blog-dir "posts/")
      org-static-blog-drafts-directory (concat ohmeta-blog-dir "drafts/")
      org-static-blog-enable-tags t
      org-export-with-toc nil
      org-export-with-section-numbers nil)

;; page-header
;; page-preamble
;; page-postamble

(setq org-static-blog-page-header
      "<meta name=\"author\" content=\"Ohmeta\">
<meta name=\"referrer\" content=\"no-referrer\">
<link href= \"static/style.css\" rel=\"stylesheet\" type=\"text/css\" />
<link rel=\"icon\" href=\"images/meta_logo.jpg\">
<script src=\"static/katex.min.js\"></script>
<script src=\"static/auto-render.min.js\"></script>
<link rel=\"stylesheet\" href=\"static/katex.min.css\">
<script>document.addEventListener(\"DOMContentLoaded\", function() { renderMathInElement(document.body); });</script>
<meta http-equiv=\"content-type\" content=\"application/xhtml+xml; charset=UTF-8\">
<meta name=\"viewport\" content=\"initial-scale=1,width=device-width,minimum-scale=1\">")

(setq org-static-blog-page-preamble
      "<div class=\"header\">
  <a href=\"https://ohmeta.github.io/\" class=\"logo\">Metagenomics Research Blog</a>
  <br>
    <a href=\"https://ohmeta.github.io/archive\">Archive</a>
    <a href=\"https://ohmeta.github.io/tags\">Tags</a>
    <a href=\"https://ohmeta.github.io/rss.xml\">RSS</a>
    <a href=\"https://ohmeta.github.io/about\">About</a>
</div>")

(setq org-static-blog-page-postamble
"        <center>
            <button id=\"disqus_button\" onclick=\"load_disqus()\">Load
            Disqus Comments</button>
        </center>
        <div id=\"disqus_thread\"></div>
        <script type=\"text/javascript\">
        function load_disqus() {
        var dsq = document.createElement('script');
        dsq.type = 'text/javascript';
        dsq.async = true;
        dsq.src = 'https://ohmeta.disqus.com/embed.js';
        (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
        document.getElementById('disqus_button').style.visibility = 'hidden';
        };
        </script>
        <center>
            <a rel=\"license\" href=
            \"https://creativecommons.org/licenses/by-sa/3.0/\"><img alt=\"Creative Commons License\"
            style=\"border-width:0\" src=
            \"https://i.creativecommons.org/l/by-sa/3.0/88x31.png\"></a><br>

            <span xmlns:dct=\"https://purl.org/dc/terms/\" href=
            \"https://purl.org/dc/dcmitype/Text\" property=
            \"dct:title\" rel=\"dct:type\">Metagenomics Research Blog</span> by
            <a xmlns:cc=\"https://creativecommons.org/ns#\" href=
            \"https://ohmeta.github.io\" property=
            \"cc:attributionName\" rel=\"cc:attributionURL\">Ohmeta
            </a> is licensed under a <a rel=\"license\" href=
            \"https://creativecommons.org/licenses/by-sa/3.0/\">Creative
            Commons Attribution-ShareAlike 3.0 Unported
            License</a>.
        </center>

    <script type=\"text/javascript\">
        var CoronaBarOptions = {\"position\":\"bottom\",
                         \"displayCases\":true,
                         \"textHeadline\":\"Spread the message. Stop the virus.\",
                         \"textStepOneTitle\":\"Hands\",
                         \"textStepOneDesc\":\"Wash often\",
                         \"textStepTwoTitle\":\"Elbow\",
                         \"textStepTwoDesc\":\"Cough into\",
                         \"textStepThreeTitle\":\"Face\",
                         \"textStepThreeDesc\":\"Don't touch\",
                         \"textStepFourTitle\":\"Space\",
                         \"textStepFourDesc\":\"Avoid crowds\",
                         \"textStepFiveTitle\":\"Home\",
                         \"textStepFiveDesc\":\"Stay inside\",
                         \"textConfirmed\":\"Confirmed\",
                         \"textRecovered\":\"Recovered\"};
    </script>
    <script type=\"text/javascript\" src=
    \"https://coronabar-53eb.kxcdn.com/coronabar.min.js\" async></script>")
