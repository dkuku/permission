defmodule WorkpermitWeb.LayoutView do
  use WorkpermitWeb, :view

  def get_active_locale_class(locale) do
    if Gettext.get_locale(WorkpermitWeb.Gettext) == locale, do: "active"
  end
end
