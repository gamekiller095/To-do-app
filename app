import { useState } from "react";
import { Card, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { format } from "date-fns";

export default function TodoApp() {
  const [tasks, setTasks] = useState([]);
  const [task, setTask] = useState("");
  const [deadline, setDeadline] = useState("");

  const addTask = () => {
    if (!task) return;
    setTasks([...tasks, { text: task, deadline, completed: false }]);
    setTask("");
    setDeadline("");
  };

  const toggleComplete = (index) => {
    const newTasks = tasks.map((t, i) =>
      i === index ? { ...t, completed: !t.completed } : t
    );
    setTasks(newTasks);
  };

  const deleteTask = (index) => {
    setTasks(tasks.filter((_, i) => i !== index));
  };

  return (
    <div className="p-6 max-w-lg mx-auto space-y-4">
      <h1 className="text-xl font-bold">To-Do App</h1>
      <div className="flex space-x-2">
        <Input value={task} onChange={(e) => setTask(e.target.value)} placeholder="Nieuwe taak" />
        <Input type="date" value={deadline} onChange={(e) => setDeadline(e.target.value)} />
        <Button onClick={addTask}>Toevoegen</Button>
      </div>
      <div className="space-y-2">
        {tasks.map((t, index) => (
          <Card key={index} className="p-4 flex justify-between items-center">
            <div>
              <p className={t.completed ? "line-through text-gray-500" : ""}>{t.text}</p>
              {t.deadline && <p className="text-sm text-gray-400">Deadline: {format(new Date(t.deadline), 'dd-MM-yyyy')}</p>}
            </div>
            <div className="flex space-x-2">
              <Button onClick={() => toggleComplete(index)} variant="outline">{t.completed ? "Heropenen" : "Voltooid"}</Button>
              <Button onClick={() => deleteTask(index)} variant="destructive">Verwijderen</Button>
            </div>
          </Card>
        ))}
      </div>
    </div>
  );
}
