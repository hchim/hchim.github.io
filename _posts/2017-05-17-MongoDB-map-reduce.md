---
layout: post
categories: Big-Data
tags: [MongoDB, MapReduce, Big Data, Node.js]

---

Map-reduce is a data processing paradigm for condensing large volumes of data into useful aggregated results.
It processes data in two steps: **map** and **reduce**. The **map** step maps every document in the data set
to a category or key; and in the **reduce** step, every key reduces all of its mapped value by aggregating all
the values with a specified algorithm.

MongoDB provides the **mapReduce** database command for support this data processing paradigm. The **mapReduce**
commands takes two functions as parameters: the map function and the reduce function. The map function defines
how to map each document to the corresponding key. The **emit** function will be invoked in the map function to
let MongoDB know that we have a mapping for this document. The following is an example of the map function:

```
// The mongoose schema
var metricSchema = mongoose.Schema({
    tag: String,
    createTime: {type: Date, default: Date.now},
    message: String, // error or msg type
    ...
});

var mapFun = function() {
  var key = this.createTime.getTime() / (1000 * 60 * 5);
  emit(key, 1);
}
```

This function maps the metric in every 5 minutes to the same key.

For those keys that have multiple values, MongoDB applies the reduce phase, which collects and condenses the aggregated data. 
The reduce function takes two parameters: key and values. The following reduce function simply summarizes the values.

```
var reduceFun = function(key, values) {
  return Array.sum(values);
}
```

MongoDB stores the results in a collection. Optionally, the output of the reduce function may pass 
through a finalize function to further condense or process the results of the aggregation.

```
var finalizeFun = function(key, reducedValues) {
    //Do something with the reduced values
    return reducedValues;
}

db.metrics.mapReduce(
    mapFun,
    reduceFun,
    {
        out: "metrics_stat",
        finalize: finalizeFun
    }
)
```

The previous example scans all the documents in the collection. We can also specify query conditions to 
run map-reduce on the selection data sets.

```
db.metrics.mapReduce(
    mapFun,
    reduceFun,
    {
        query: { ts: { $gt: ISODate('2011-11-05 00:00:00') } },
        out: "metrics_stat",
        finalize: finalizeFun
    }
)
```

For more information of the mapReduce command of MongoDB, please read this [document](https://docs.mongodb.com/manual/reference/method/db.collection.mapReduce/#db.collection.mapReduce).