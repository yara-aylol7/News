import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildArticleItem(article, context) => InkWell(
      onTap: () {
        /* navigateTo(
          context,
          WebViewContainer(article['url']),
        );*/
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage('${article['urlToImage']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Container(
                height: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );
Widget ArticleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: 10,
      ),
      fallback: (context) => isSearch
          ? Container()
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
Widget defaultFormfield({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  bool? isPassword,
  Function? suffixPressed,

  // required Function save,
}) {
  return TextFormField(
    //obscureText: isPassword!,
    // onSaved: save(),

    onTap: () {
      onTap!();
    },
    controller: controller,
    keyboardType: type,
    autocorrect: true,
    enableSuggestions: true,
    textCapitalization: TextCapitalization.words,
    //autovalidate: true,
    validator: (value) {
      validate(value);
    },
    onFieldSubmitted: (value) {
      onSubmit!(value);
    },
    onChanged: (value) {
      onChange!(value);
    },

    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(
        prefix,
      ),
      suffixIcon: suffix != null
          ? IconButton(
              icon: Icon(
                suffix,
              ),
              onPressed: () {
                suffixPressed!();
              },
            )
          : null,
      border: OutlineInputBorder(),
    ),
  );
}

void navigateTo(context, Widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
    );
