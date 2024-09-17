import 'package:flutter/material.dart';
import 'package:my_project/Providers/masrof_provider.dart';
import 'package:my_project/Services/session_manager.dart';
import 'package:provider/provider.dart';
import 'EditPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final sessionManager = Provider.of<SessionManager>(context, listen: false);

    return GestureDetector(
      onTap: () {
        sessionManager.resetSessionTimer(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Masrof Entries'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                sessionManager.resetSessionTimer(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const EditMasrofPage()));
              },
            ),
          ],
        ),
        body: Consumer<MasrofProvider>(
          builder: (context, masrofProvider, child) {
            if (masrofProvider.masrofList.isEmpty) {
              return const Center(child: Text('No entries found.'));
            }

            return ListView.builder(
              itemCount: masrofProvider.masrofList.length,
              itemBuilder: (context, index) {
                final masrof = masrofProvider.masrofList[index];
                return Card(
                  child: ListTile(
                    title: Text('${masrof.operationType} - \$${masrof.value}'),
                    subtitle: Text(masrof.reason),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        EditMasrofPage(masrof: masrof)));
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            masrofProvider.deleteMasrof(masrof.id!);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
