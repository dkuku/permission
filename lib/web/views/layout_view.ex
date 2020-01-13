defmodule Web.LayoutView do
  use Web, :view

  def get_active_locale_class(locale) do
    if Gettext.get_locale(Web.Gettext) == locale, do: "active"
  end
end
