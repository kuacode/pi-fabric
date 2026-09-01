const FABRIC_COMPONENT_REGISTER_EVENT = "pi-fabric:component:register:v1";
const FABRIC_COMPONENT_DISCOVER_EVENT = "pi-fabric:component:discover:v1";

const ROLE_GUIDANCE = `Pi Fabric Plus role guidance: when delegation is useful, keep roles explicit and bounded. Use existing Fabric agent APIs (agents.run, agents.spawn, agents.create) with a task, non-goals, owned paths, expected output, verification command, and stop condition. Keep implementation workers from editing overlapping paths; synthesize and verify in the parent.`;

const roleGuidanceComponent = {
  name: "kuacode-role-guidance",
  description: "Adds Kuacode role-routing guidance through Fabric's component plane.",
  guarantee: "revertible",
  activate(context) {
    context.guide({
      label: "role-guidance",
      targets: ["main", "participant"],
      content: ROLE_GUIDANCE,
    });
  },
};

export default function piFabricPlus(pi) {
  pi.events.emit(FABRIC_COMPONENT_REGISTER_EVENT, {
    version: 1,
    component: roleGuidanceComponent,
    overwrite: true,
  });

  pi.events.on(FABRIC_COMPONENT_DISCOVER_EVENT, (discovery) => {
    discovery.register(roleGuidanceComponent, { overwrite: true });
  });

  pi.registerCommand({
    name: "fabric-plus",
    description: "Show pi-fabric-plus status",
    async run() {
      return "pi-fabric-plus loaded. Enable component kuacode-role-guidance in fabric.json to add role guidance.";
    },
  });
}
