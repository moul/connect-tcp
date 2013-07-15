exports.merge = (a, b) ->
  if a and b
    for key of b
      a[key] = b[key]
  return a