import 'package:flutter/material.dart';
import 'package:rse/all.dart';

class AccountList extends StatefulWidget {
  const AccountList({super.key});

  @override
  State<AccountList> createState() => _AccountListState();
}

class _AccountListState extends State<AccountList> {
  late Map<int, bool> expandedMap = {};
  List accounts = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getAccounts();
  }

  List<ExpansionPanel> _buildChildren(data) {
    List<ExpansionPanel> items = [];
    for (var i = 0; i < data.length; i++) {
      final item = data[i];
      items.add(ExpansionPanel(
        canTapOnHeader: true,
        headerBuilder: (BuildContext context, bool isExpanded) {
          return ListTile(
            title: Text(item['name']),
          );
        },
        body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: C(context, 'primary'),
            ),
          ),
          child: Column(
            children: [
              ListTile(
                title: const Text('Routing Number'),
                subtitle: Text(item['routingNumber'].toString()),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Account Number'),
                subtitle: Text(item['accountNumber'].toString()),
                onTap: () {},
              ),
              ListTile(
                  title: const Text('Delete'),
                  subtitle: const Text(
                      'To delete this panel, tap the trash can icon'),
                  trailing: const Icon(Icons.delete),
                  onTap: () {
                    setState(() {
                      LocalStorageService.bankAccountRemove(
                          item['accountNumber']);
                      accounts
                          .removeWhere((currentItem) => item == currentItem);
                    });
                  }),
            ],
          ),
        ),
        isExpanded: expandedMap[i] ?? false,
      ));
    }
    return items;
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int idx, bool isExpanded) {
        setState(() {
          expandedMap[idx] = !isExpanded;
        });
      },
      children: _buildChildren(accounts),
    );
  }

  _getAccounts() async {
    final newAccounts = await LocalStorageService.bankAccountsList();
    p(newAccounts);
    setState(() {
      accounts = newAccounts;
    });
  }
}
