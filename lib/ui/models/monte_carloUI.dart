import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Models
import '../../data/models/monte_carlo_activity.dart';

class MonteCarloUI extends ChangeNotifier {
  final List<MonteCarloActivity> _activities = [];
  MonteCarloActivity? _selectedActivity;
  final TextEditingController nameController = TextEditingController(),
      minimumController = TextEditingController(),
      maximumController = TextEditingController();
  MonteCarloSimulation? _simulation;

  MonteCarloUI();

  // Getters
  List<MonteCarloActivity> get activities => _activities;
  MonteCarloActivity? get selectedActivity => _selectedActivity;
  MonteCarloSimulation? get simulation => _simulation;

  // Setters
  set selectedActivity(MonteCarloActivity? value) {
    // Select activity
    _selectedActivity = value;

    // Setting controllers
    setControllers();

    // Update
    notifyListeners();
  }

  set simulation(MonteCarloSimulation? value) {
    _simulation = value;
    notifyListeners();
  }

  // Methods
  void update() => notifyListeners();

  void deleteActivity({required MonteCarloActivity activity}) {
    // Remove element from the list
    _activities.remove(activity);

    // Clear selected Activity
    _selectedActivity = null;

    // Setting controllers
    setControllers();

    // Update UI
    notifyListeners();
  }

  void setControllers() {
    if (_selectedActivity == null) {
      nameController.text = "";
      minimumController.text = "";
      maximumController.text = "";
    } else {
      nameController.text = selectedActivity!.name;
      minimumController.text = selectedActivity!.minimum.toString();
      maximumController.text = selectedActivity!.maximum.toString();
    }
  }

  List<Widget> toWidgetList(
          {required BuildContext context, double spacing = 8.0}) =>
      _activities
          .map(
            (activity) => Padding(
              padding: EdgeInsets.symmetric(
                vertical: spacing / 2,
              ),
              child: Card(
                child: ListTile(
                  title: Text(
                    "Actividad: ${activity.name}",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  subtitle: Text(
                    "Mínimo: ${activity.minimum}\n"
                    "Máximo: ${activity.maximum}",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  trailing: SizedBox(
                    width: 150,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Ink(
                            decoration: ShapeDecoration(
                              color: Theme.of(context).primaryColor,
                              shape: const CircleBorder(),
                            ),
                            child: IconButton(
                              onPressed: () => selectedActivity = activity,
                              icon:
                                  const Icon(Icons.edit, color: Colors.white70),
                            ),
                          ),
                          Ink(
                            decoration: ShapeDecoration(
                              color: Theme.of(context).primaryColor,
                              shape: const CircleBorder(),
                            ),
                            child: IconButton(
                              onPressed: () =>
                                  deleteActivity(activity: activity),
                              icon: const Icon(
                                Icons.remove_circle,
                                color: Colors.white70,
                              ),
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList();
}
