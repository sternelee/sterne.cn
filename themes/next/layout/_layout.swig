<!doctype html>

{% set html_class = 'theme-next ' + theme.scheme %}
{% if theme.use_motion %}
  {% set html_class = html_class + ' use-motion' %}
{% endif %}

<html class="{{ html_class | lower }}" lang="{{ config.language }}">
<head>
  {% include '_partials/head.swig' %}
  <title>{% block title %}{% endblock %}</title>
</head>

<body itemscope itemtype="http://schema.org/WebPage" lang="{{ page.lang || page.language || config.language }}">

  {% include '_scripts/third-party/analytics.swig' %}

  {% set container_class = "container one-collumn " %}
  {% if theme.sidebar.position %}
    {% set container_class = container_class + 'sidebar-position-' + theme.sidebar.position %}
  {% endif %}

  <div class="{{ container_class }} {% block page_class %}{% endblock %} ">
    <div class="headband"></div>

    <header id="header" class="header" itemscope itemtype="http://schema.org/WPHeader">
      <div class="header-inner"> {%- include '_partials/header.swig' %} </div>
    </header>

    <main id="main" class="main">
      <div class="main-inner">
        <div class="content-wrap">
          <div id="content" class="content">
            {% block content %}{% endblock %}          
          </div>
          {% include '_partials/duoshuo-hot-articles.swig' %}
          {% include '_partials/comments.swig' %}
        </div>
        {% if theme.sidebar.display !== 'remove' %}
          {% block sidebar %}{% endblock %}
        {% endif %}
      </div>
    </main>

    <footer id="footer" class="footer">
      <div class="footer-inner">
        {% include '_partials/footer.swig' %}
        {% include '_scripts/third-party/analytics/busuanzi-counter.swig' %}
        {% block footer %}{% endblock %}
      </div>
    </footer>

    {% if not theme.sidebar.b2t %}
      <div class="back-to-top">
        <i class="fa fa-arrow-up"></i>
        {% if theme.sidebar.scrollpercent %}
          <span id="scrollpercent"><span>0</span>%</span>
        {% endif %}
      </div>
    {% endif %}
    
  </div>

  {% include '_scripts/vendors.swig' %}
  {% include '_scripts/commons.swig' %}

  {% set scheme_script = '_scripts/schemes/' + theme.scheme | lower + '.swig' %}
  {% include scheme_script %}

  {% block script_extra %}{% endblock %}

  {% include '_scripts/boostrap.swig' %}

  {% include '_scripts/third-party/comments.swig' %}
  {% include '_scripts/third-party/tinysou.swig' %}
  {% include '_scripts/third-party/localsearch.swig' %}
  {% include '_scripts/third-party/mathjax.swig' %}
  {% include '_scripts/third-party/lean-analytics.swig' %}
  {% include '_scripts/baidu-push.swig' %}
  {% include '_components/algolia-search/assets.swig' %}

  {% if theme.exturl %}
    {% include '_scripts/third-party/exturl.swig' %}
  {% endif %}
  <script src="{{ url_for(theme.js) }}/jump.js"></script>
  <script>
    $(document).ready(function(){
      $(".site-author-image,.menu-item a,.post-button .btn").jrumble();
    });
  </script>
  <script src="{{ url_for(theme.js) }}/segment.min.js"></script>
  <script src="{{ url_for(theme.js) }}/d3-ease.v0.6.js"></script>
  <script src="{{ url_for(theme.js) }}/letters.js"></script>
  <script>
  //选择元素
  var el = document.querySelector('.site-title');
  //每个选项可以定义为单个也可以定义为数组
  var options = {
      size: 50,         // 字体大小，决定文字的高度，px
      weight: 6,         // 粗体，px
      rounded: false,    // 字母结尾圆角
      color: ['#fc6423','#222'],  // 字体颜色
      duration: 1,       // 每个字母的动画展示时长 (seconds)
      delay: [0, 0.4],  // 每个字母间的动画延时
      fade: 2,         // 渐显效果的时长(seconds)
      easing: d3_ease.easeCubicInOut.ease,   // 缓冲动画效果
      individualDelays: false     // 默认false，如果设置成false，则动画效果会从左到右过度展示，如果是true，字母动画效果是同步展示
  };
  var myText = new Letters(el, options);
  myText.show();
  </script>
</body>
</html>
