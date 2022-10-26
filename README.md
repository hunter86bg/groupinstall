# `groupinstall` Cookbook

This cookbook provides a resource to install RHEL package groups, since the default Yum and DNF `package` providers cannot (CHEF-1392).
Forked from https://github.com/mmmorris1975/yumgroup

## Requirements

- Chef 15.3+

### Supported Platforms

- RHEL & family (e.g. CentOS, Rocky)
- Fedora

## Usage

```ruby
groupinstall 'web-server'
```
```ruby
groupinstall 'jboss-eap7' do
  group 'jboss-eap7'
  flush_cache [:before]
  cache_error_fatal true
end
```

### Resource properties

| Property            | Type                       | Default       | Description                                                                                 |
| ------------------- | -------------------------- | ------------- | ------------------------------------------------------------------------------------------- |
| `group`             | String                     | resource name | Name of the group to install. Either the name (`Basic Web Server`) or the id (`web-server`) |
| `options`           | String                     |               | Any options to pass to Yum / DNF when installing                                            |
| `flush_cache`       | Array: `[:before, :after]` | `[]`          | Update the metadata cache before or after the package action                                |
| `cache_error_fatal` | `true` / `false`           | `false`       | Make updates of the metadata cache fatal                                                    |

## License and Authors

Authors: Mike Morris
License: 3-clause BSD
