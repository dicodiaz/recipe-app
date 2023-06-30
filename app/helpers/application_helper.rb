module ApplicationHelper
  def flash_class(level)
    bootstrap_alert_class = {
      'success' => 'alert-success',
      'error' => 'alert-danger',
      'notice' => 'alert-info',
      'alert' => 'alert-danger',
      'warn' => 'alert-warning'
    }
    bootstrap_alert_class[level]
  end

  def navbar_link_to(text, path)
    link_to text, path, class: "nav-link #{request.fullpath == path && 'active'}"
  end
end
