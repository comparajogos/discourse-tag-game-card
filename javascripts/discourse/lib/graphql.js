import { ajax } from "discourse/lib/ajax";

export default async function graphql(query, variables) {
  return await ajax(settings.main_site_graphql_url, {
    type: "POST",
    headers: { "Content-Type": "application/json" },
    data: JSON.stringify({ query, variables }),
  });
}
