# Open Standards

Now that Hero has a visual cluster view they’re starting to feel a little more aware about what’s happening around them. But, let’s be honest, they’re still woefully underinformed. 

They know they need this thing called 'observability’... but getting started is overwhelming!

First, observability data (also called `telemetry data`, or just `telemetry`) needs to be generated, exposed, and, ideally, correlated with other data in the system. It also might be filtered or transformed at this step. The observability data gets collected, and maybe filtered and/or transformed here too. Then the data gets stored, and Hero has so many questions. Is the data stored stored in a distributed way, across the cluster, or is it centralized? Is it stored short term? Long-term? How does Hero keep storage costs down when their large and complex system generates a TREMENDOUS amount of data? And then, once Hero designs their storage solution, the reward is that Hero can implement tools that query and visualize the data, and trigger alerting! 

“Alerting!” Hero thinks. “Some reward that is.”

Kidding aside, Hero knows that besides being able to find and fix problems quickly, observability unlocks advanced functionality like performance improvements, cost optimization, understanding app behavior, and even advanced deployment techniques. Heck yeah.

No matter what choices Hero makes as they design their observability solution, when so many tools work with this data, standardization is key. 

Standardization is how many tools can work together, making observability solutions tool-agnostic. Standardization is also how system data can be correlated with other data in the system, resulting in a holistic view for Hero. 

This all feels so far away! Pie-in-the-sky. But Hero knows that the first step toward their final goal of understanding system behavior is standardization.

…but wait. Right out of the gate, there seem to be TWO standards for how to collect and express observability data, Prometheus for metrics and OpenTelemetry for everything (including metrics). What the what? What are these two technologies, exactly? Do the two technologies work together? Does Hero need both, or does Hero need to choose?

## Choice 1: OpenTelemetry

OpenTelemetry was founded on the idea that telemetry data should be a built-in part of all software. It is a model for how to translate system events into useful data for observability. But what makes observability data useful? Useful telemetry data has two qualities. First, it is highly correlated with other data in the system. Second, it is the result of ubiquitous standardization. So how does OpenTelemetry achieve this?

Practically, OpenTelemetry is three things:

* **OpenTelemetry is a [specification](https://github.com/open-telemetry/opentelemetry-specification).** The OpenTelemetry specification describes the cross-language requirements and expectations for all OpenTelemetry implementations. It is a collection of [more than one hundred markdown documents](https://github.com/open-telemetry/opentelemetry-specification/blob/main/specification/README.md) that define every aspect you can imagine regarding an observability system.

* **OpenTelemetry is a [standard](https://en.wikipedia.org/wiki/Software_standard).** This basically means that it is widely adopted across the industry, enabling interoperability between observability implementations. 

* **OpenTelemetry is a suite of software.** This includes language-specific APIs that standardize how developers translate code-level events into observability signals, SDKs that listen to those APIs and add context such as simultaneous events, whether the data is part of a larger transaction, and additional metadata (standardized, of course). This also includes the OpenTelemetry Collector reference implementation, which we’ll discuss later in the ‘Data Pipelines’ episode


[![You MUST Instrument Your Code With OpenTelemetry (OTEL)!](https://img.youtube.com/vi/oe5YYh9mhzw/0.jpg)](https://youtu.be/oe5YYh9mhzw)
[![Open Standards in Observability with OpenTelemetry](https://img.youtube.com/vi/7SccIT9rAuY/0.jpg)](https://youtu.be/7SccIT9rAuY)
[![Distributed Tracing With Jaeger And OpenTelemetry In Kubernetes](https://img.youtube.com/vi/FK0uh-7nDSg/0.jpg)](https://youtu.be/FK0uh-7nDSg)
[![Observability 2.0: Not Just Another Buzzword](https://img.youtube.com/vi/dcVD6sNtAiI/0.jpg)](https://youtu.be/dcVD6sNtAiI)
* [Official site](https://opentelemetry.io)

## Choice 2: Prometheus

Prometheus is the industry standard for collecting, processing, and storing time-series metrics. Metrics measure events over time, and, at a minimum, they consist of a numerical value, a label, and a time stamp.

Prometheus metrics have a standardized format, and Prometheus metrics can be generated in three ways:

* Many technologies generate Prometheus metrics out-of-the-box.

* For home-grown apps, developers can use Prometheus client libraries to directly instrument application code to generate Prometheus metrics.

* If you want metrics that aren't auto-generated, there is almost certainly an exporter you can install/use to generate (aka `export`) whatever particular Prometheus metrics you want from various systems--databases, hardware, software, APIs, EVERYTHING. [There are hundreds of exporters mentioned in the Prometheus documentation.](https://prometheus.io/docs/instrumenting/exporters/)

Three examples of exporters include [Kepler](https://github.com/sustainable-computing-io/kepler)\*, which exports metrics about Kubernetes’ energy consumption, [OpenCost](https://www.opencost.io/)\*, which exports metrics pertaining to the cost of your Kubernetes clusters, and [Kube State Metrics (KSM)](https://github.com/kubernetes/kube-state-metrics), which captures the actual state of Kubernetes vs the desired state of Kubernetes over time.

\*We’ll cover these technologies in upcoming You Choose episodes!

[![Infrastructure by Design with Meshery](https://img.youtube.com/vi/gt085CrPRb8/0.jpg)](https://youtu.be/gt085CrPRb8)
[![Infrastructure by Design with Meshery](https://img.youtube.com/vi/LRXU-cj6CDA/0.jpg)](https://youtu.be/LRXU-cj6CDA)
* [Official site](https://prometheus.io)

## What Is Your Choice?

There doesn’t have to be a choice here, and you will likely use aspects of each tool in your observability solution. Prometheus metrics & OpenTelemetry metrics work together. OpenTelemetry understands Prometheus metrics, and, as of September 2024, the next release of Prometheus will start using OpenTelemetry SDKs.

* [OpenTelemetry](opentelemetry.md)
* [Prometheus](openmetrics.md)
