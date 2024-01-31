import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:le_vech/Widgets/string_const.dart';

//Get Data

@override
Future<List<QueryDocumentSnapshot<Object?>>> firebaseGet(String collection) async {
  List<QueryDocumentSnapshot> firebaseData = <QueryDocumentSnapshot>[];

  var storeData = await FirebaseFirestore.instance.collection(AppString.baseCollection).doc(AppString.baseDoc).collection(collection).get();

  firebaseData = storeData.docs;

  return firebaseData;
}

@override
Future<List<QueryDocumentSnapshot<Object?>>> firebaseGetOrderBy(String collection, String field) async {
  List<QueryDocumentSnapshot> firebaseData = <QueryDocumentSnapshot>[];

  try {
    var storeData = await FirebaseFirestore.instance.collection(AppString.baseCollection).doc(AppString.baseDoc).collection(collection).orderBy(field, descending: false).get();

    firebaseData = storeData.docs;
  } on Exception catch (e) {
    print(e);
  }

  return firebaseData;
}

@override
Future<DocumentSnapshot<Map<String, dynamic>>> firebaseGetdocs(String collection, String docs) async {
  var storeData = await FirebaseFirestore.instance.collection(AppString.baseCollection).doc(AppString.baseDoc).collection(collection).doc(docs).get();

  return storeData;
}

// get data with where

@override
Future<List<QueryDocumentSnapshot<Object?>>> firebaseGetwhere(String collection, String field, String fieldValue) async {
  List<QueryDocumentSnapshot> firebaseData = <QueryDocumentSnapshot>[];
  try {
    var storeData = await FirebaseFirestore.instance.collection(AppString.baseCollection).doc(AppString.baseDoc).collection(collection).where(field, isEqualTo: fieldValue).get();

    firebaseData = storeData.docs;

    return firebaseData;
  } catch (e) {
    return firebaseData;
  }
}

///pagination
/*                     cbbbbbbbbbbbbbbbbbbbbbf                        */
@override
Future<List<QueryDocumentSnapshot<Object?>>> firebaseLimite(String collection,int limit ) async {
  List<QueryDocumentSnapshot> firebaseData = <QueryDocumentSnapshot>[];
  try {
    //var storeData = await FirebaseFirestore.instance.collection(AppString.baseCollection).doc(AppString.baseDoc).collection(collection).where(field, isEqualTo: fieldValue).get();
    var storeData = await FirebaseFirestore.instance.collection(AppString.baseCollection).doc(AppString.baseDoc).collection(collection).orderBy(descending:true, 'name').limit(limit).get();

    firebaseData = storeData.docs;

    return firebaseData;
  } catch (e) {
    return firebaseData;
  }
}
/*                         fggggggggggggggggggggggggg           */
@override
Future<List<QueryDocumentSnapshot<Object?>>> firebasePaginationData(String collection,DocumentSnapshot startAfter ,int limit ) async {
  List<QueryDocumentSnapshot> firebaseData = <QueryDocumentSnapshot>[];
  try {
    var storeData = await FirebaseFirestore.instance.collection(AppString.baseCollection).doc(AppString.baseDoc).collection(collection).orderBy(descending:true,'name').startAfterDocument(startAfter).limit(limit).get();
    firebaseData = storeData.docs;
    return firebaseData;
  } catch (e) {
    return firebaseData;
  }
}
// get data with where
/*                             categarishas                              */
@override
Future<List<QueryDocumentSnapshot<Object?>>> firebaseGetwhereLimit(String collection, String field, String fieldValue,int limit) async {
  List<QueryDocumentSnapshot> firebaseData = <QueryDocumentSnapshot>[];
  try {
    // var storeData = await FirebaseFirestore.instance.collection(AppString.baseCollection).doc(AppString.baseDoc).collection(collection).where(field, isEqualTo: fieldValue).get();
    var storeData = await FirebaseFirestore.instance.collection(AppString.baseCollection).doc(AppString.baseDoc).collection(collection).where(field, isEqualTo: fieldValue).orderBy(descending:true, 'name').limit(limit).get();

    firebaseData = storeData.docs;

    return firebaseData;
  } catch (e) {
    return firebaseData;
  }
}
/*dvgggggggggggggggggggggggggg                            categaris                     grrrrrrrrrrrrrr*/
@override
Future<List<QueryDocumentSnapshot<Object?>>> firebaseCategrishPaginationData(String collection,String field, String fieldValue,DocumentSnapshot startAfter ,int limit ) async {
  List<QueryDocumentSnapshot> firebaseData = <QueryDocumentSnapshot>[];
  try {
  //  var storeData = await FirebaseFirestore.instance.collection(AppString.baseCollection).doc(AppString.baseDoc).collection(collection).orderBy(descending:true,'name').startAfterDocument(startAfter).limit(limit).get();
    var storeData = await FirebaseFirestore.instance.collection(AppString.baseCollection).doc(AppString.baseDoc).collection(collection).where(field, isEqualTo: fieldValue).orderBy(descending:true,'name').startAfterDocument(startAfter).limit(limit).get();
    firebaseData = storeData.docs;
    return firebaseData;
  } catch (e) {
    return firebaseData;
  }
}


///Store data
@override
void storeDataDocs(String collection, String docsId, Map<String, dynamic> data) async {
  try {
    await FirebaseFirestore.instance.collection(AppString.baseCollection).doc(AppString.baseDoc).collection(collection).doc(docsId).set(data);
  } on Exception catch (e) {
    print(e);
  }
}


@override
void storeDataDocsSubCollection(String collection, String docsId, String subCollection, Map<String, dynamic> data) async {
  try {
    await FirebaseFirestore.instance.collection(AppString.baseCollection).doc(AppString.baseDoc).collection(collection).doc(docsId).collection(subCollection).doc().set(data);
  } on Exception catch (e) {
    print(e);
  }
}

@override
void storeData(String collection, Map<String, dynamic> data) async {
  await FirebaseFirestore.instance.collection(AppString.baseCollection).doc(AppString.baseDoc).collection(collection).doc().set(data);
}

// Update Data
@override
void updateData(String collection, String docId, Map<String, dynamic> data) async {
  await FirebaseFirestore.instance.collection(AppString.baseCollection).doc(AppString.baseDoc).collection(collection).doc(docId).update(data);
}



