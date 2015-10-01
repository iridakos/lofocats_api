# LofoCats API
LofoCats API is a simple API built with Ruby on Rails created for demo purposes. (There's also a simple application consuming it, built with Rails: [LofoCats UI](https://github.com/iridakos/lofocats_ui)).

# Functionality
The API provides endpoints for interacting with a registry of lost and found cats.

# Endpoints
### Users
<code>GET /api/users</code> Retrieves all users. Requires administrator priviledges.

<code>GET /api/users/:id</code> Retrieves a user. Requires administrator priviledges.

<code>POST /api/users</code> Creates a new user. Requires administrator priviledges.

<code>PUT/PATCH /api/users/:id</code> Updates a user. Requires administrator priviledges.

<code>DELETE /api/users/:id</code> Deletes a user. Requires administrator priviledges.

### Session

<code>POST /api/sessions</code> Creates an authentication token to be used for subsequent requests for authorization.

<code>DELETE /api/sessions</code> Deletes the previously authentication token. Requires signed in user.

### Cat entries

<code>GET /api/cat_entries</code> Retrieves cat entries. Available for all users.

<code>GET /api/cat_entries/:id</code> Retrieves a cat entry. Available for all users.

<code>POST /api/cat_entries</code> Creates a new cat entry. Only for signed in users.

<code>UPDATE /api/cat_entries/:id</code> Updates a cat entry. Administrators can update all entries, signed in users can update only their own entries. Guests can't update any entry.

<code>DELETE /api/cat_entries/:id</code> Deletes a cat entry. Administrators can delete all entries, signed in users can delete only their own entries. Guests can't delete any entry.

# Authentication & Authorization

In order to consume endpoints that require a signed in user (administrator or not) you must first obtain an authentication token by posting to the respective sessions endpoint described above. You have to use this token as the <code>Authorization</code> header of your requests to the desired endpoints.

# Setting up the application

* Clone the repository.
* Execute <code>bundle install</code> to install the required gems.
* Execute <code>rake db:setup</code> to setup the database.
* Execute <code>rake db:load\_demo\_data</code> to load some demo data to the application.
* Execute <code>rails server</code> to start the application on the default port.

If you loaded the demo data, the following users are available:

<table>
	<thead>
		<tr>
			<th>Email</th>
			<th>Password</th>
			<th>Administrator</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>administrator@lofocats.com</td>
			<td>administrator</td>
			<td>Yes</td>
		</tr>
		<tr>
			<td>user@lofocats.com</td>
			<td>user123456</td>
			<td>No</td>
		</tr>
		<tr>
			<td>another_user@lofocats.com</td>
			<td>user123456</td>
			<td>No</td>
		</tr>
	</tbody>
</table>

# Testing

The application contains RSpec specs. To run the tests:

* Execute <code>rake db:test:prepare</code>
* Execute <code>rspec</code>

# TODO

* Document request parameters & responses
