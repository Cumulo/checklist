
= exports.add $ \ (db action)
  db.update :groups $ \ (groups)
    groups.push action.data

= exports.remove $ \ (db action)
  db.delete action.data

= exports.update $ \ (db action)
  var
    groupId $ action.data.get :groupId
    text $ action.data.get :text
  db.update :groups $ \ (groups)
    groups.map $ \ (group)
      cond (is (group.get :id) groupId)
        group.set :text text
        , group

= exports.toggle $ \ (db action)
  var
    groupId $ action.data.get :groupId
    groupDone $ action.data.get :done
  db.update :groups $ \ (groups)
    groups.map $ \ (group)
      cond (is (group.get :id) groupId)
        group.update :children $ \ (children)
          children.map $ \ (item)
            item.set :done groupDone
        , group

= exports.remove $ \ (db action)
  var
    groupId $ action.data.get :groupId
  db.update :groups $ \ (groups)
    groups.filterNot $ \ (group)
      is (group.get :id) groupId
