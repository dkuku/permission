defmodule Workpermit.Tenants do
  alias Workpermit.Repo, as: Repo

  def list do
    Triplex.all Repo
  end

  def new(name) when is_bitstring(name) do
    if Triplex.exists? name, Repo do
      {:error, :tenant_exists}
    else
      Triplex.create name, Repo
    end
  end

  def remove(name) when is_bitstring(name) do
    Triplex.drop name, Repo
  end

  def rename(current_name, new_name) do
    if Triplex.exists?(new_name, Repo) do
      {:error, :tenant_exists}
    else
      Triplex.rename(current_name, new_name, Repo)
    end
  end
end

#iex(3)> Workpermit.Tenants.list               
#[]
#iex(4)> Workpermit.Tenants.new("arst")          
#{:ok, "arst"}
#iex(5)> Workpermit.Tenants.list       
#["wpt_arst"]
#iex(6)> Workpermit.Tenants.rename("ars","ar")
#{:error,
# "ERROR 3F000 (invalid_schema_name) schema \"wpt_ars\" does not exist"}
#iex(7)> Workpermit.Tenants.rename("arst","ar")
#{:ok, "ar"}
#iex(8)> Workpermit.Tenants.new("ar")          
#{:error, :tenant_exists}
#iex(9)> Workpermit.Tenants.remove("ar")
#{:ok, "ar"}
#iex(10)> Workpermit.Tenants.list               
#[]
