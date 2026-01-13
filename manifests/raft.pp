# @summary A member of raft cluster
#
# @param id
#        must be unique in cluster
# @param address
# @param port
#
# @api private
define clickhouse_keeper::raft (
  Integer $id,
  String  $address,
  Integer $port,
  String  $target,
  String  $cluster,
  Boolean $export_raft,
) {
  if $export_raft {
    @@concat::fragment { $title:
      target  => $target,
      content => epp("${module_name}/raft.xml.epp", {
          'id'      => $id,
          'address' => $address,
          'port'    => $port
      }),
      order   => 50,
      tag     => "clickhouse_keeper::config-${cluster}",
    }
  } else {
    concat::fragment { $title:
      target  => $target,
      content => epp("${module_name}/raft.xml.epp", {
          'id'      => $id,
          'address' => $address,
          'port'    => $port
      }),
      order   => 50,
      tag     => "clickhouse_keeper::config-${cluster}",
    }
  }
}
