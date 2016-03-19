<div class="copyright" >
  {% set current = date(Date.now(), "YYYY") %}
  &copy; {% if theme.since and theme.since != current %} {{ theme.since }} - {% endif %}
  <span itemprop="copyrightYear">{{ current }}</span>
  <span class="with-love">
    <i class="icon-next-heart fa fa-heart"></i>
  </span>
  <span>Contents of this blog is licensed under <a class="theme-link" href="https://creativecommons.org/licenses/by-nc-nd/4.0/">CC BY-NC-ND 4.0</a></span>
  <!-- GoStats Simple HTML Based Code -->
    <a target="_blank" title="流量统计" href="http://gostats.cn"><img alt="流量统计" 
    src="http://monster.gostats.cn/bin/count/a_478563/t_7/i_3/z_0/show_visitors/counter.png" 
    style="border-width:0" /></a>
  <!-- End GoStats Simple HTML Based Code -->
</div>


{% block footer %}{% endblock %}
