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

### Monitoring

<code>GET /api/health</code> Returns HTTP 200 and "OK" if the app is running. Else HTTP 500.

<code>GET /api/health/database</code> Returns HTTP 200 and "OK" if the current migration level can be read from the database. Else HTTP 500.

<code>GET /api/health/migration</code> Returns HTTP 200 and "OK" if database migration level matches db/migrations. Else HTTP 500.

<code>GET /api/health/cache</code> Returns HTTP 200 and "OK" if a value can be written to the cache. Else HTTP 500.

<code>GET /api/health/all</code> Returns HTTP 200 and "OK" if all checks passes. Else HTTP 500.

See [`health_check`](https://github.com/ianheggie/health_check) for more details.

<code>GET /api/metrics</code> Returns Prometheus-formatted application metrics.

# Authentication & Authorization

In order to consume endpoints that require a signed in user (administrator or not) you must first obtain an authentication token by posting to the respective sessions endpoint described above. You have to use this token as the <code>Authorization</code> header of your requests to the desired endpoints.

# Setting up the application

* Clone the repository.
* Execute `docker-compose up` to setup the environment.
* Execute `docker-compose run --rm api rake db:load_demo_data` to load some demo data to the application.

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

* Execute `docker-compose run --rm api sh -c 'bundle install --with test && rake db:test:prepare && rspec'`

# TODO

* Document request parameters & responses
