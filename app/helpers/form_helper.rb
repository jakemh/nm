module FormHelper
  def grid_helper(col)
    "<div class=\"container-fluid no-space\">
      <div class=\"row no-space\">
        <div class=\"col-sm-#{col} no-space\">
        ".html_safe

          yield

        "</div>
        </div>
      </div>".html_safe
      end
end
