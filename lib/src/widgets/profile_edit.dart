import 'package:flutter/material.dart';

class ProfileEdit extends StatefulWidget {
 // const ProfileEdit({Key? key, required this.titleController, required this.secretController}) : super(key: key);
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController secretController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile'),),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Stack(
                alignment: Alignment.center,
                children: const [
                Icon(Icons.account_circle_outlined, size: 120,),
                Positioned(
                  bottom: 2,
                    right: 4,
                    child: Icon(Icons.edit, size: 48, color: Colors.deepOrange),
                ),
                ],
              ),
              const SizedBox(height: 10),
              TextField(
                autofocus: true,
                controller: titleController,
                decoration: const InputDecoration(
                  label: Text('User Name'),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10,),
              TextField(
                controller: secretController,
                decoration: const InputDecoration(
                  label: Text('Secret'),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10,),
              TextField(
                controller: secretController,
                decoration: const InputDecoration(
                  label: Text('Something else'),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 25),
              TextButton.icon(
                icon: const Icon(Icons.update_rounded),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 50
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.deepOrange,
                  shape: const StadiumBorder(),
                ),
                onPressed: () => Navigator.pop(context),
                label: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
