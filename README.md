# README
Dave Holmes' Shopify resume app "The Shoppies"
This repo houses the backend code for Dave Holmes' Shopify resume app "The Shoppies". Please refer here for the project's frontend code and installation instructions. https://github.com/daveholmes88/shopify-front-end

The Shoppies:

An application that fetches movie titles through the OMDb API and allows users to nominate those movies for "The Shoppies" 

Each user must login with a valid username and password. Each user is only allowed to nominate up to five movies. A full list of the nominated movies can be found showing all users the movies that are currently winning. 

You can see the website at https://dave-holmes-shopify.herokuapp.com/

Backend Prerequisites

Rails 6

PostgreSQL

Backend Installation Overview:

After cloning this repo, first run the Rails server:

cd shopify-back-end

bundle install

Database installation:

rails db:create

rails db:migrate

Run Rails server: rails s
