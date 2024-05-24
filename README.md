# Members Project Management

## Introduction
Ruby on Rails app to keep track of members of different teams and their projects.

## Requirements
[Requirements](https://sprintfwd.notion.site/SprintFWD-Rails-Takehome-189326691bd84cbcbbf8aeacff2ae300)
## Schema

![ Schema](https://i.postimg.cc/zGybYCc4/Screenshot-2024-05-23-at-9-41-20-PM.png)

## Installation

### Prerequisites
- Ruby version `3.3.0`
- Rails version `7.1.3`
- Database `Postgres`
### Setup
1. Clone the repository:
    `git clone https://github.com/Cyn-tax/project-management cd project-management` 
2. Install dependencies:
    `bundle install`    
3. Set up the database:
    `rails db:create rails db:migrate rails db:seed`
4. Start the Rails server:
    `rails server`
## Usage
Below is a list of available endpoints for this project, along with the request bodies where applicable.
### Health Check
- **GET /up**
	- **Description**: Check the health status of the application.
	- **Path Helper**: `rails_health_check_path`
### API v1 Endpoints
#### Teams
- **GET /api/v1/teams**
	- **Description**: Retrieve a list of all teams.
- **POST /api/v1/teams**
	- **Description**: Create a new team.
	- **Request Body**:
	```
	{ "team": { "name": "test" } }
	```
- **GET /api/v1/teams/:id**
	- **Description**: Retrieve details of a specific team.
- **PATCH /api/v1/teams/:id**
	- **Description**: Update details of a specific team.
	- **Request Body**:
	```
	{ "team": { "name": "test" } }
	```
- **DELETE /api/v1/teams/:id**
	- **Description**: Delete a specific team.
- **GET /api/v1/teams/:id/members**
	- **Description**: Retrieve a list of members of a specific team.
#### Projects
- **GET /api/v1/projects**
	- **Description**: Retrieve a list of all projects.
- **POST /api/v1/projects**
	- **Description**: Create a new project.
	- **Request Body**:
	```
	{ "project": { "name": "test" } }
	```
- **GET /api/v1/projects/:id**
	- **Description**: Retrieve details of a specific project.
- **PATCH /api/v1/projects/:id**
	- **Description**: Update details of a specific project.
	- **Request Body**:
	```
	{ "project": { "name": "test" } }
	```
- **DELETE /api/v1/projects/:id**
	- **Description**: Delete a specific project.
- **GET /api/v1/projects/:id/members**
	- **Description**: Retrieve a list of members of a specific project.
#### Members
- **GET /api/v1/members**
	- **Description**: Retrieve a list of all members.
- **POST /api/v1/members**
	- **Description**: Create a new member.
- **Request Body**:
	```
	{ "member": { "first_name": "test", "last_name": "test", "city": "test", "country": "test", "state": "test", "team_id": "1" } }
	```
- **GET /api/v1/members/:id**
	- **Description**: Retrieve details of a specific member.
- **PATCH /api/v1/members/:id**
	- **Description**: Update details of a specific member.
- **Request Body**:

	```
	{ "member": { "first_name": "test", "last_name": "test", "city": "test", "country": "test", "state": "test", "team_id": "1" } }
	```
- **DELETE /api/v1/members/:id**
	- **Description**: Delete a specific member.
#### Member Projects
- **POST /api/v1/member_projects**
	- **Description**: Assign members to projects.
- **Request Body**:
	```
	{ "member_project": { "member_id": "1", "project_id": "1" } }
	```
These endpoints provide comprehensive CRUD operations for teams, projects, and members, along with specialized routes for managing team and project members.
## Testing

To run the test suite, execute:

`rspec`