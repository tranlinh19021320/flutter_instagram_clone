import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/providers/user_provider.dart';
import 'package:flutter_instagram_clone/resources/firestore_methods.dart';
import 'package:flutter_instagram_clone/utils/colors.dart';
import 'package:flutter_instagram_clone/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;

  void postImage(String uid,
    String username,
    String profImage,) async {
      setState(() {
        _isLoading = true;
      });
      try {
        String res = await FirestoreMethods().uploadPost(
          _descriptionController.text, 
          _file!, 
          uid, 
          username, 
          profImage,);

        if (res == 'success') {
          showSnackBar("Posted!", context);
          setState(() {
          _isLoading = false;
        });
          clearImage();
        } else {
          showSnackBar(res, context);
          setState(() {
          _isLoading = false;
        });
        }

        
      } catch(err) {
        showSnackBar(err.toString(), context);

      }

    
  }
  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Create a Post'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(28),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(
                    ImageSource.camera,
                  );
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(28),
                child: const Text('Choose from gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(
                    ImageSource.gallery,
                  );
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(28),
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }
  @override
  void dispose() {
    
    super.dispose();
    _descriptionController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;

    return _file == null ? Center(
      child: IconButton(
        icon: const Icon(Icons.upload, size: 60,),
        onPressed: () => _selectImage(context),),

    ) 
    : Scaffold(
      appBar: AppBar(
        backgroundColor: black0Color,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_sharp),
          onPressed: clearImage,
        ),
        title: const Text('Post To'),
        centerTitle: false,
        actions: [
          TextButton(
              onPressed: () => postImage(user.uid, user.username, user.photoURL),
              child: const Text(
                'Post',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ))
        ],
      ),
      body: Column(
        children: [
          _isLoading ? const LinearProgressIndicator() : const Padding(padding: EdgeInsets.only(top: 0)),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user.photoURL),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child: TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    
                    hintText: "Write a caption ..",
                    border: InputBorder.none,
                  ),
                  maxLines: 8,
                ),
              ),
              SizedBox(
                height: 45,
                width: 45,
                child: AspectRatio(
                  aspectRatio: 487 / 451,
                  child: Container(
                    decoration: BoxDecoration(
                    image: DecorationImage(
                      image: MemoryImage(_file!),
                      fit: BoxFit.fill,
                      alignment: FractionalOffset.topCenter,
                    )),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
