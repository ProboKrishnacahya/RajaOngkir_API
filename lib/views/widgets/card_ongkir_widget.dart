part of 'widgets.dart';

class CardOngkirWidget extends StatefulWidget {
  final Costs costs;
  const CardOngkirWidget(this.costs, {super.key});

  @override
  _CardOngkirWidgetState createState() => _CardOngkirWidgetState();
}

class _CardOngkirWidgetState extends State<CardOngkirWidget> {
  @override
  Widget build(BuildContext context) {
    Costs c = widget.costs;
    return Card(
      color: Style.white,
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {},
        child: ListTile(
          contentPadding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
          leading: const CircleAvatar(
            child: Text(
              "R",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text("${c.description} (${c.service})",
              style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Text(
                "Biaya: ${Helper.toIdr(c.cost!.elementAt(0).value)}",
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 8),
              Text(
                "Estimasi sampai: ${c.cost!.elementAt(0).etd}",
                style: TextStyle(
                  fontSize: 12,
                  color: Style.grey500,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
