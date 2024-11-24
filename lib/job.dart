import 'dart:convert';

import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dart_appwrite/models.dart';
import 'package:dotenv/dotenv.dart';
import 'package:starter_template/constants.dart';
import 'package:starter_template/response.dart';
import 'package:http/http.dart' as http;

var env = DotEnv(includePlatformEnvironment: true)..load();

/// Retrieves latest post from Wordpress
Future<PostResponse> fetchLatestPost() async {
  final url = '$POSTS_URL/wp-json/wp/v2/posts?per_page=1&orderby=date&order=desc';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    List<dynamic> responseData = json.decode(response.body);

    if (responseData.isNotEmpty) {
      return PostResponse.fromJson(responseData.first);
    } else {
      throw Exception('No data received from API');
    }
  } else {
    throw Exception('Failed to load data from API');
  }
}

/// Retrieves latest post id from Appwrite Database
Future<int> getLatestId(Databases databases) async {
  Document result = await databases.getDocument(
    databaseId: DATABASE_ID,
    collectionId: COLLECTION_ID,
    documentId: DOCUMENT_ID,
  );
  return result.data['id'] as int;
}

/// Updates latest post id from Appwrite Database
Future<void> updateLatestId(Databases databases, int id) async {
  // update file
  await databases.updateDocument(
    databaseId: DATABASE_ID,
    collectionId: COLLECTION_ID,
    documentId: DOCUMENT_ID,
    data: {'id': id},
  );
}

/// Sends a push notification using FCM
Future<void> sendPushNotification(Messaging messaging) async {
  await messaging.createPush(
    messageId: 'new_post',
    title: 'New Blog Post',
    body: 'Gordon Ferguson just posted a new article to his blog. Check it out!',
  );
}

Future<void> run(dynamic context) async {
  Client client = Client()
      .setEndpoint(APPWRITE_URL)
      .setKey(env.getOrElse('API_KEY', () => throw Exception('API_KEY not set.')))
      .setProject(PROJECT_ID);
  Databases databases = Databases(client);

  final latestPost = await fetchLatestPost();
  final id = latestPost.id;
  final storedId = await getLatestId(databases);

  if (id != storedId) {
    await updateLatestId(databases, id);
    context.log("New post detected. Updating ID and creating push.");
    Messaging messaging = Messaging(client);
    await sendPushNotification(messaging);
    context.log("Push created successfully.");
  } else {
    context.log("ID's match. No action needed.");
  }

  context.log("Stored ID: $storedId; Latest ID: $id");
}
