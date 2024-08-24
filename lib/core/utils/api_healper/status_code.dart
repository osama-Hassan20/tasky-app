class StatusCode {
  static const int ok = 200; //refresh successfully
  static const int badRequest = 400;
  static const int unauthorized = 401; //not authorized need to refresh
  static const int forbidden = 403; //refresh failed
  static const int notFound = 404;
  static const int conflict = 409;
  static const int internalServerError = 500;
}

// enabled: _loading,child: ListView.builder
// (
// itemCount: 7,
// itemBuilder: (context, index) {
// return Card(
// child: ListTile(
// title: Text('Item number $index as title'),
// subtitle: const Text('Subtitle here'),
// trailing: const Icon(Icons.ac_unit),
// ),
// );
// },
// )
// ,
// )