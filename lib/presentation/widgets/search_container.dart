import 'package:flutter/material.dart';
import 'package:jokes/main.dart';
import 'package:jokes/presentation/widgets/entry_field.dart';

class SearchContainer extends StatelessWidget {
  final bool isSearch;
  final Function(String)? onSearched;
  const SearchContainer({Key? key, this.isSearch = false, this.onSearched})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        color: context.primaryColor(),
        padding: isSearch ? const EdgeInsets.symmetric(vertical: 12.0) : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSearch) ...{
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: EntryField(
                      hint: 'Enter the receipt number ...',
                      prefixWidget: Icon(
                        Icons.search,
                        color: context.primaryColor(),
                        size: 20.0,
                      ),
                      radius: 24.0,
                      hintColor: Colors.grey,
                      onSubmitted: (val) {
                        if (onSearched != null) {
                          onSearched!(val);
                        }
                      },
                      suffixWidget: Container(
                        padding: const EdgeInsets.all(8.0),
                        width: 30.0,
                        margin: const EdgeInsets.only(
                          right: 4.0,
                          top: 4.0,
                          bottom: 4.0,
                        ),
                        decoration: BoxDecoration(
                          color: context.accentColor(),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.qr_code_scanner_rounded,
                          size: 18.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                ],
              )
            } else
              Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.0),
                ),
                height: 48.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 6.0,
                        ),
                        Icon(
                          Icons.search,
                          color: context.primaryColor(),
                          size: 20.0,
                        ),
                        const SizedBox(
                          width: 6.0,
                        ),
                        Text(
                          'Enter the receipt number ...',
                          style: context.customStyle(
                            color: Colors.grey,
                            size: 14.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: context.accentColor(),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.qr_code_scanner_rounded,
                        size: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(
              height: 8.0,
            ),
          ],
        ),
      ),
    );
  }
}
