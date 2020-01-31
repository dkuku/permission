defmodule Web.LayoutView do
  use Web, :view

  def get_active_locale_class(locale) do
    if Gettext.get_locale(Web.Gettext) == locale do
      "text-black"
    else
      "text-gray-dark"
    end
  end
end
