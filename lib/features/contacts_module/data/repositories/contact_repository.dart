import 'package:chatapp_firebase/core/data/models/user_model.dart';
import 'package:chatapp_firebase/features/contacts_module/data/data_providers/contacts_provider.dart';

class ContactRepository {
  final ContactsProvider _contactsProvider;

  ContactRepository({ContactsProvider? contactProvider})
    : _contactsProvider = contactProvider ?? ContactsProvider();

  Future<List<UserModel>> getAllContacts() async {
    final contactListJson = await _contactsProvider.fetchAllContactsJson();

    print('this is list of json : $contactListJson');

    return contactListJson.map((contactJson) {
      return UserModel.fromJson(contactJson);
    }).toList();
  }
}
