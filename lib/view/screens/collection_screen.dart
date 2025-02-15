import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/collection_provider.dart';
import '../../model/collection.dart';


class CollectionsScreen extends StatelessWidget {
  const CollectionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'My Collections',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: Navigate to all collections
                    },
                    child: const Text(
                      'See All',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                  ),

                ],
              ),
              const SizedBox(height: 20),
              // Collections List
              Expanded(
                child: Consumer<CollectionsProvider>(
                  builder: (context, collectionsProvider, child) {
                    final collections = collectionsProvider.collections;
                    return ListView.builder(
                      itemCount: collections.length,
                      itemBuilder: (context, index) {
                        return CollectionItem(
                          collection: collections[index],
                          onEdit: () => _showEditCollectionDialog(
                            context,
                            collections[index],
                          ),
                          onDelete: () => _showDeleteConfirmation(
                            context,
                            collections[index],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 100,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      _showAddCollectionDialog(context);
                    },
                    icon: const Icon(
                        color: Colors.white,
                        Icons.add_circle_outline,
                        size: 20),
                    label: const Text('Add'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFCE7B81),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  void _showAddCollectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => CollectionDialog(
        title: 'Add Collection',
        onSave: (name, description) {
          Provider.of<CollectionsProvider>(context, listen: false)
              .addCollection(name, description);
        },
      ),
    );
  }

  void _showEditCollectionDialog(BuildContext context, Collection collection) {
    showDialog(
      context: context,
      builder: (ctx) => CollectionDialog(
        title: 'Edit Collection',
        initialName: collection.name,
        initialDescription: collection.description,
        onSave: (name, description) {
          Provider.of<CollectionsProvider>(context, listen: false)
              .updateCollection(collection.id, name, description);
        },
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, Collection collection) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Collection'),
        content: Text('Are you sure you want to delete "${collection.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<CollectionsProvider>(context, listen: false)
                  .deleteCollection(collection.id);
              Navigator.pop(ctx);
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

class CollectionItem extends StatelessWidget {
  final Collection collection;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CollectionItem({
    Key? key,
    required this.collection,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Icon(Icons.folder_outlined, color: Colors.grey),
        ),
        title: Text(
          '${collection.name}(${collection.itemCount})',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          collection.description,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit_outlined, color: Colors.grey),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.grey),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}

class CollectionDialog extends StatefulWidget {
  final String title;
  final String? initialName;
  final String? initialDescription;
  final Function(String name, String description) onSave;

  const CollectionDialog({
    Key? key,
    required this.title,
    this.initialName,
    this.initialDescription,
    required this.onSave,
  }) : super(key: key);

  @override
  State<CollectionDialog> createState() => _CollectionDialogState();
}

class _CollectionDialogState extends State<CollectionDialog> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _descriptionController = TextEditingController(text: widget.initialDescription);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Collection Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_nameController.text.isNotEmpty) {
              widget.onSave(_nameController.text, _descriptionController.text);
              Navigator.pop(context);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFCE7B81),
          ),
          child: const Text('Save'),
        ),
      ],
    );
  }
}