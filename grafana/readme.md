外部HostAddress
grafana account

Database User Permissions
 CREATE USER 'grafanaReader' IDENTIFIED BY 'password';
 GRANT SELECT ON mydatabase.mytable TO 'grafanaReader';


Table queries

If the Format as query option is set to Table then you can basically do any type of SQL query. The table panel will automatically show the results of whatever columns and rows your query returns.

Query editor with example query:

The query:

SELECT
  title as 'Title',
  user.login as 'Created By' ,
  dashboard.created as 'Created On'
 FROM dashboard
INNER JOIN user on user.id = dashboard.created_by
WHERE $__timeFilter(dashboard.created)

You can control the name of the Table panel columns by using regular as SQL column selection syntax.

The resulting table panel:

Time series queries

If you set Format as to Time series, for use in Graph panel for example, then the query must return a column named time that returns either a SQL datetime or any numeric datatype representing Unix epoch. Any column except time and metric is treated as a value column. You may return a column named metric that is used as metric name for the value column. If you return multiple value columns and a column named metric then this column is used as prefix for the series name (only available in Grafana 5.3+).

Resultsets of time series queries need to be sorted by time.

Example with metric column:

SELECT
  $__timeGroup(time_date_time,'5m'),
  min(value_double),
  'min' as metric
FROM test_data
WHERE $__timeFilter(time_date_time)
GROUP BY time
ORDER BY time

Example using the fill parameter in the $__timeGroup macro to convert null values to be zero instead:

SELECT
  $__timeGroup(createdAt,'5m',0),
  sum(value_double) as value,
  measurement
FROM test_data
WHERE
  $__timeFilter(createdAt)
GROUP BY time, measurement
ORDER BY time

Example with multiple columns:

SELECT
  $__timeGroup(time_date_time,'5m'),
  min(value_double) as min_value,
  max(value_double) as max_value
FROM test_data
WHERE $__timeFilter(time_date_time)
GROUP BY time
ORDER BY time

Currently, there is no support for a dynamic group by time based on time range and panel width. This is something we plan to add.
Templating

This feature is currently available in the nightly builds and will be included in the 5.0.0 release.

Instead of hard-coding things like server, application and sensor name in your metric queries you can use variables in their place. Variables are shown as dropdown select boxes at the top of the dashboard. These dropdowns make it easy to change the data being displayed in your dashboard.

Check out the Templating documentation for an introduction to the templating feature and the different types of template variables.
Query Variable

If you add a template variable of the type Query, you can write a MySQL query that can return things like measurement names, key names or key values that are shown as a dropdown select box.

For example, you can have a variable that contains all values for the hostname column in a table if you specify a query like this in the templating variable Query setting.

SELECT hostname FROM my_host

A query can return multiple columns and Grafana will automatically create a list from them. For example, the query below will return a list with values from hostname and hostname2.

SELECT my_host.hostname, my_other_host.hostname2 FROM my_host JOIN my_other_host ON my_host.city = my_other_host.city

To use time range dependent macros like $__timeFilter(column) in your query the refresh mode of the template variable needs to be set to On Time Range Change.

SELECT event_name FROM event_log WHERE $__timeFilter(time_column)

Another option is a query that can create a key/value variable. The query should return two columns that are named __text and __value. The __text column value should be unique (if it is not unique then the first value is used). The options in the dropdown will have a text and value that allows you to have a friendly name as text and an id as the value. An example query with hostname as the text and id as the value:

SELECT hostname AS __text, id AS __value FROM my_host

You can also create nested variables. For example if you had another variable named region. Then you could have the hosts variable only show hosts from the current selected region with a query like this (if region is a multi-value variable then use the IN comparison operator rather than = to match against multiple values):

SELECT hostname FROM my_host  WHERE region IN($region)

Using __searchFilter to filter results in Query Variable

    Available from Grafana 6.5 and above

Using __searchFilter in the query field will filter the query result based on what the user types in the dropdown select box. When nothing has been entered by the user the default value for __searchFilter is %.

    Important that you surround the __searchFilter expression with quotes as Grafana does not do this for you.

The example below shows how to use __searchFilter as part of the query field to enable searching for hostname while the user types in the dropdown select box.

Query

SELECT hostname FROM my_host  WHERE hostname LIKE '$__searchFilter'

Using Variables in Queries

From Grafana 4.3.0 to 4.6.0, template variables are always quoted automatically so if it is a string value do not wrap them in quotes in where clauses.

From Grafana 4.7.0, template variable values are only quoted when the template variable is a multi-value.

If the variable is a multi-value variable then use the IN comparison operator rather than = to match against multiple values.

There are two syntaxes:

$<varname> Example with a template variable named hostname:

SELECT
  UNIX_TIMESTAMP(atimestamp) as time,
  aint as value,
  avarchar as metric
FROM my_table
WHERE $__timeFilter(atimestamp) and hostname in($hostname)
ORDER BY atimestamp ASC

[[varname]] Example with a template variable named hostname:

SELECT
  UNIX_TIMESTAMP(atimestamp) as time,
  aint as value,
  avarchar as metric
FROM my_table
WHERE $__timeFilter(atimestamp) and hostname in([[hostname]])
ORDER BY atimestamp ASC

Disabling Quoting for Multi-value Variables

Grafana automatically creates a quoted, comma-separated string for multi-value variables. For example: if server01 and server02 are selected then it will be formatted as: 'server01', 'server02'. Do disable quoting, use the csv formatting option for variables:

${servers:csv}

Read more about variable formatting options in the Variables documentation.
Annotations

Annotations allow you to overlay rich event information on top of graphs. You add annotation queries via the Dashboard menu / Annotations view.

Example query using time column with epoch values:

SELECT
  epoch_time as time,
  metric1 as text,
  CONCAT(tag1, ',', tag2) as tags
FROM
  public.test_data
WHERE
  $__unixEpochFilter(epoch_time)

Example region query using time and timeend columns with epoch values:

    Only available in Grafana v6.6+.

SELECT
  epoch_time as time,
  epoch_timeend as timeend,
  metric1 as text,
  CONCAT(tag1, ',', tag2) as tags
FROM
  public.test_data
WHERE
  $__unixEpochFilter(epoch_time)

Example query using time column of native SQL date/time data type:

SELECT
  native_date_time as time,
  metric1 as text,
  CONCAT(tag1, ',', tag2) as tags
FROM
  public.test_data
WHERE
  $__timeFilter(native_date_time)

Name 	Description
time 	The name of the date/time field. Could be a column with a native SQL date/time data type or epoch value.
timeend 	Optional name of the end date/time field. Could be a column with a native SQL date/time data type or epoch value. (Grafana v6.6+)
text 	Event description field.
tags 	Optional field name to use for event tags as a comma separated string.
Alerting

Time series queries should work in alerting conditions. Table formatted queries are not yet supported in alert rule conditions.
Configure the data source with provisioning

It’s now possible to configure data sources using config files with Grafana’s provisioning system. You can read more about how it works and all the settings you can set for data sources on the provisioning docs page

Here are some provisioning examples for this data source.

apiVersion: 1

datasources:
  - name: MySQL
    type: mysql
    url: localhost:3306
    database: grafana
    user: grafana
    password: password
    jsonData:
      maxOpenConns: 0         # Grafana v5.4+
      maxIdleConns: 2         # Grafana v5.4+
      connMaxLifetime: 14400  # Grafana v5.4+
