import 'package:flutter/material.dart';
import 'package:haba/src/apis/supabase_creds.dart';
import 'package:haba/src/utils/show_snackbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Avatar extends StatefulWidget {
  const Avatar({
    Key? key,
    required this.imageUrl,
    required this.onUpload,
  }) : super(key: key);
  final String? imageUrl;
  final void Function(String) onUpload;

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 28,),
        if (widget.imageUrl == null || widget.imageUrl!.isEmpty)
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(60),
            ),
           // color: Colors.black38,
            child: const Center(
                child: Icon(Icons.account_circle_rounded, size: 68),
            ),
          )
        else
          Image.network(
            widget.imageUrl!,
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          ),
        const SizedBox(height: 16,),
        OutlinedButton(
            onPressed: _isLoading ? null : _upload,
            child: Text(_isLoading ? 'Uploading...' : 'Select'))
      ],
    );
  }

  Future<void> _upload() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 300,
      maxHeight: 300,
    );
    if (imageFile == null) {
      return;
    }
    setState(() => _isLoading = true);

    try {
      final bytes = await imageFile.readAsBytes();
      final fileExt = imageFile.path.split('.').last;
      final fileName = '${DateTime.now().toIso8601String()}.$fileExt';
      final filePath = fileName;
      await SupabaseCredentials.supabase.storage.from('avatars').uploadBinary(
        filePath,
        bytes,
        fileOptions: FileOptions(contentType: imageFile.mimeType),
      );
      final imageUrlResponse = await SupabaseCredentials.supabase.storage
          .from('avatars')
          .createSignedUrl(filePath, 60 * 60 * 24 * 365 * 10);
      widget.onUpload(imageUrlResponse);
    } on StorageException catch (error) {
      if (mounted) {
        context.showErrorSnackBar(message: error.message);
      }
    } catch (error) {
      if (mounted) {
        context.showErrorSnackBar(message: 'Unexpected error occurred');
      }
    }

    setState(() => _isLoading = false);
  }

}
