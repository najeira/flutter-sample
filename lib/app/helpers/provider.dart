import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:store_builder/store_builder.dart';

StoredSubject<T> subjectOf<T>(BuildContext context, {bool listen = true}) {
  return Provider.of<StoredSubject<T>>(context, listen: listen);
}

T valueOf<T>(BuildContext context, {bool listen = true}) {
  return subjectOf<T>(context, listen: listen)?.value;
}
