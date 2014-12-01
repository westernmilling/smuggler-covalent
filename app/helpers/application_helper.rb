module ApplicationHelper
  def return_url(default_url)
    if params[:return_url]
      if URI.parse(params[:return_url]).class.name.include?('HTTP')
        URI.parse(params[:return_url]).to_s
      else
        # REVIEW: Consider logging this
        raise Exception.new('None HTTP return url detected, possible XSS attempt.')
      end
    else
      default_url
    end
  rescue
    default_url
  end
end
