# README

Having a `Room` that can have many `Chairs`, where `Chairs` is an STI with the subclasses `LoungeChair` and
`SwingChair`, we can trigger a scope bug when combine two scopes on `Room` to filter with specific chairs.
This `Rails` contains a peproduction. To trigger run `rspec --format d`, which will also print the actual SQL.
